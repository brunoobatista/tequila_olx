import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppColors.dart';
import 'package:olx_tequila/models/Anuncio.dart';
import 'package:olx_tequila/services/AnuncioService.dart';
import 'package:olx_tequila/views/anuncios/widgets/CardAnuncioWidget.dart';

class MeusAnunciosWidget extends StatefulWidget {
  const MeusAnunciosWidget({Key? key}) : super(key: key);

  @override
  _MeusAnunciosWidgetState createState() => _MeusAnunciosWidgetState();
}

class _MeusAnunciosWidgetState extends State<MeusAnunciosWidget> {
  final _controller = StreamController<List<Anuncio>>.broadcast();
  AnuncioService _service = AnuncioService();
  List<Anuncio> anuncios = [];

  Future<void> _preencherMeusAnuncios() async {
    List<Anuncio> anuncs = await _service.getMeusAnuncios();
    _controller.add(anuncs);
    print(this._controller.stream.length);
  }

  void refreshData() {
    _preencherMeusAnuncios();
  }

  @override
  void initState() {
    _preencherMeusAnuncios();
    super.initState();
  }

  @override
  void dispose() {
    this._controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus anúncios'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.sDeepPurple,
        foregroundColor: AppColors.pText,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, '/novo-anuncio',
              arguments: {'function': refreshData});
        },
      ),
      body: streamBuilderWidget(),
    );
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
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return CardAnuncioWidget(
                  anuncio: snapshot.data[index],
                );
              },
            );
          default:
            return Text('Erro ao carregar dados');
        }
      },
    );
  }
}
