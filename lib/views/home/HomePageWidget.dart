import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppColors.dart';
import 'package:olx_tequila/models/Anuncio.dart';
import 'package:olx_tequila/modelview/UserTequila.dart';
import 'package:olx_tequila/repositories/FirebaseAuthRepository.dart';
import 'package:olx_tequila/services/AnuncioService.dart';
import 'package:olx_tequila/services/HomeService.dart';
import 'package:olx_tequila/utils/FilterEncodeJson.dart';
import 'package:olx_tequila/utils/InitDropdown.dart';
import 'package:olx_tequila/views/anuncios/widgets/CardAnuncioWidget.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  UserTequila userTequila = UserTequila.logOff();

  final FirebaseAuthRepository firebaseRepository = FirebaseAuthRepository();
  final _controller = StreamController<List<Anuncio>>.broadcast();
  List<DropdownMenuItem<String>> _estadosDropItens = [];
  List<DropdownMenuItem<String>> _categoriaDropItens = [];

  String? _currentValueEstado;
  String? _currentValueCategoria;
  String _title = 'Tequila Business';

  final pageViewController = PageController();
  final InitDropdown _initDropdown = InitDropdown();
  final HomeService homeService = HomeService();
  final AnuncioService _service = AnuncioService();

  List<String> itensMenu = [];
  List<Anuncio> anuncios = [];

  _escolhaMenuItem(String itemEscolhido) async {
    switch (itemEscolhido.parse) {
      case ItemMenus.meus_anuncios:
        Navigator.pushNamed(context, '/meus-anuncios');
        break;
      case ItemMenus.cadastrar:
        Navigator.pushNamed(context, '/registrar');
        break;
      case ItemMenus.entrar:
        Navigator.pushNamed(context, '/login');
        break;
      case ItemMenus.deslogar:
        userTequila = await firebaseRepository.logout();
        setState(() {
          itensMenu = homeService.getMenuItens(userTequila.isLogged);
          _title = 'Tequila Business';
        });
        // Navigator.pushReplacementNamed(context, '/home');
        break;
    }
  }

  _preencheAnuncios(QuerySnapshot snapshot) {
    this.anuncios.clear();
    for (DocumentSnapshot doc in snapshot.docs) {
      var dado = doc.data();
      Anuncio anuncio = Anuncio.fromJson(
          jsonEncode(dado, toEncodable: FilterEncodeJson.tratarData));

      this.anuncios.add(anuncio);
    }
    _controller.add(this.anuncios);
  }

  _consultaAnuncios() {
    _service.getAnuncios(
        fn: this._preencheAnuncios,
        regiao: this._currentValueEstado,
        categoria: this._currentValueCategoria);
  }

  _initDrops() async {
    var cats = await this._initDropdown.initCategorias();
    setState(() {
      this._estadosDropItens = this._initDropdown.initEstados();
      this._categoriaDropItens = cats;
    });
  }

  verifyUserIsLogged() async {
    userTequila = await firebaseRepository.getCurrentUser();
    if (userTequila.isLogged)
      setState(() {
        _title = 'Bruno Batista';
      });
    itensMenu = homeService.getMenuItens(userTequila.isLogged);
  }

  @override
  void initState() {
    super.initState();
    verifyUserIsLogged();
    _initDrops();
    _consultaAnuncios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
        backgroundColor: AppColors.pPurple,
        // automaticallyImplyLeading: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: _escolhaMenuItem,
            itemBuilder: (context) {
              return itensMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          // width: double.infinity,
          // height: 500,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: Center(
                        child: DropdownButton<String>(
                          items: this._estadosDropItens,
                          iconEnabledColor: AppColors.sDeepPurpleLight,
                          value: this._currentValueEstado,
                          onChanged: (estado) {
                            setState(() {
                              this._currentValueEstado = estado;
                              this._consultaAnuncios();
                            });
                          },
                          // style: TextStyle(
                          //     fontSize: 22, color: AppColors.sDeepPurpleDark),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 2,
                    color: Colors.grey[200],
                  ),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: Center(
                        child: DropdownButton<String>(
                          items: this._categoriaDropItens,
                          iconEnabledColor: AppColors.sDeepPurpleLight,
                          value: this._currentValueCategoria,
                          onChanged: (categoria) {
                            setState(() {
                              this._currentValueCategoria = categoria;
                              this._consultaAnuncios();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: this.streamBuilderWidget(),
              )
            ],
          ),
        ),
      ),
    );
  }

  teste(Anuncio anuncio) {
    print('^%%%%%%%%%%%%%%%%%%%%%%%%');
    print(anuncio.toString());
  }

  Widget streamBuilderWidget() {
    return StreamBuilder(
      stream: _controller.stream,
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
          case ConnectionState.active:
            if (snapshot.data.length == 0) {
              return Container(
                  padding: EdgeInsets.all(25),
                  child: Text('Não foram encontrados anúncios'));
            }
            return Expanded(
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return CardAnuncioWidget(
                    anuncio: snapshot.data[index],
                    onTapItem: this.teste,
                  );
                },
              ),
            );
          default:
            return Text('Não foram encontrados anúncios');
        }
      },
    );
  }
}
