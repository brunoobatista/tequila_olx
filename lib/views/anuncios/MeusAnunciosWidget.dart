import 'dart:async';

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

  Future<Stream<List<Anuncio>>> _preencherMeusAnuncios() async {
    print('ANTES DO STATE');
    Stream<List<Anuncio>> anuncs = _service.getMeusAnuncios().asStream();
    anuncs.listen((event) {
      _controller.add(event);
    });
    print('DEPOIS DO STATE');
    // setState(() {
    //   anuncios = anuncs;
    // });
    print('DEPOIS DO STATE 2');
    return anuncs;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _preencherMeusAnuncios();
    print('INIT STATE');
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
          Navigator.pushNamed(context, '/novo-anuncio');
        },
      ),
      body: StreamBuilder(
        stream: _controller.stream,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
              break;
            case ConnectionState.active:
            case ConnectionState.none:
              if (!snapshot.hasData) return Text('Erro ao carregado os dados');
              return ListView.builder(
                itemCount: anuncios.length,
                itemBuilder: (_, index) {
                  print('CARREGOU LIST');
                  return CardAnuncioWidget(
                    anuncio: anuncios[index],
                  );
                },
              );
            default:
              return Text('Erro ao carregar dados');
          }
        },
      ),
    );
  }
}

// FutureBuilder<List<Anuncio>>(
//         future: _preencherMeusAnuncios(),
//         builder: (context, AsyncSnapshot snapshot) {
//           if (!snapshot.hasData) {
//             print('TA NO IFFFF');
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           } else {
//             print('TA NO ELSE');
//             List<Anuncio> an = snapshot.data;
//             return Container(
//               child: ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 itemCount: an.length,
//                 itemBuilder: (_, index) {
//                   print('CARREGOU LIST');
//                   return Text('teste');
//                   // return CardAnuncioWidget(
//                   //   anuncio: snapshot.data[index],
//                   // );
//                 },
//               ),
//             );
//           }
//         },
//       ),

// ListView.builder(
//           itemCount: anuncios.length,
//           itemBuilder: (_, index) {
//             print('CARREGOU LIST');
//             return CardAnuncioWidget(
//               anuncio: anuncios[index],
//             );
//           }),
