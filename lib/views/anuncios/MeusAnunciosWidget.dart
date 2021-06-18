import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppColors.dart';
import 'package:olx_tequila/views/anuncios/widgets/CardAnuncioWidget.dart';

class MeusAnunciosWidget extends StatefulWidget {
  const MeusAnunciosWidget({Key? key}) : super(key: key);

  @override
  _MeusAnunciosWidgetState createState() => _MeusAnunciosWidgetState();
}

class _MeusAnunciosWidgetState extends State<MeusAnunciosWidget> {
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
      body: ListView.builder(
          itemCount: 4,
          itemBuilder: (_, index) {
            return CardAnuncioWidget();
          }),
    );
  }
}
