import 'dart:io';

import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppPadding.dart';
import 'package:olx_tequila/views/anuncios/widgets/ListViewCustomWidget.dart';
import 'package:olx_tequila/views/widgets/BtnElevetedCustomWidget.dart';

class NovoAnuncioWidget extends StatefulWidget {
  const NovoAnuncioWidget({Key? key}) : super(key: key);

  @override
  _NovoAnuncioWidgetState createState() => _NovoAnuncioWidgetState();
}

class _NovoAnuncioWidgetState extends State<NovoAnuncioWidget> {
  final _formKey = GlobalKey<FormState>();
  final List<File> _listImages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Anúncio'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppPadding.horizontal,
            vertical: AppPadding.horizontal8),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FormField<List>(
                initialValue: _listImages,
                validator: (images) {
                  print('@@@@@@@@@@@');
                  print(_listImages.length);
                  if (images!.length == 0)
                    return 'Necessário fornecer uma imagem';
                  return null;
                },
                builder: (state) {
                  return Column(
                    children: [
                      Container(
                          height: 100,
                          child: ListViewCustomWidget(
                              listImages: _listImages,
                              onTap: () {
                                print('tasd asd');
                              })),
                      if (state.hasError)
                        Container(
                          child: Text(
                            "${state.errorText}",
                            style: TextStyle(color: Colors.red, fontSize: 14),
                          ),
                        ),
                    ],
                  );
                },
              ),
              Row(
                children: [
                  Text('Estado'),
                  Text('Categoria'),
                ],
              ),
              Text('campos de input'),
              BtnElevetedCustomWidget.defaultBtn(
                  text: 'Adicionar',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      print('testando form key0');
                      print(this._listImages.length);
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
