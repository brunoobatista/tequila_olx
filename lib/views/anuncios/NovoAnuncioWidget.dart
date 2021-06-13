import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:olx_tequila/core/AppPadding.dart';
import 'package:olx_tequila/models/Anuncio.dart';
import 'package:olx_tequila/models/Categoria.dart';
import 'package:olx_tequila/repositories/FirebaseDBRepository.dart';
import 'package:olx_tequila/services/AnuncioService.dart';
import 'package:olx_tequila/utils/validators/RequiredValidatorCustomObject.dart';
import 'package:olx_tequila/views/anuncios/widgets/ListViewCustomWidget.dart';
import 'package:olx_tequila/views/widgets/BtnElevetedCustomWidget.dart';
import 'package:olx_tequila/views/widgets/DropdownCustomWidget.dart';
import 'package:olx_tequila/views/widgets/TextFormFieldCustomWidget.dart';

class NovoAnuncioWidget extends StatefulWidget {
  const NovoAnuncioWidget({Key? key}) : super(key: key);

  @override
  _NovoAnuncioWidgetState createState() => _NovoAnuncioWidgetState();
}

class _NovoAnuncioWidgetState extends State<NovoAnuncioWidget> {
  final _formKey = GlobalKey<FormState>();
  final List<File> _listImages = [];
  final List<DropdownMenuItem<String>> _estadosDropItens = [];
  final List<DropdownMenuItem<String>> _categoriaDropItens = [];
  final FirebaseDBRepository firebaseRepository = FirebaseDBRepository();

  final AnuncioService _anuncioService = AnuncioService();
  final anuncio = Anuncio();
  bool isPressed = false;
  String? _currentValueEstado;
  String? _currentValueCategoria;

  _initEstados() {
    Estados.listaEstadosSigla.asMap().forEach((key, value) {
      _estadosDropItens.add(
        DropdownMenuItem(
          child: Text(value),
          value: value,
        ),
      );
    });
  }

  _initCategorias() async {
    List<Categoria> categorias = await firebaseRepository.getCategorias();
    setState(() {
      categorias.asMap().forEach((key, categoria) {
        _categoriaDropItens.add(
          DropdownMenuItem(
            child: Text(categoria.label),
            value: categoria.value,
          ),
        );
      });
    });
  }

  _saveAnuncio(BuildContext context) async {
    // Anuncio novoAnuncio;
    setState(() {
      isPressed = true;
    });
    await _anuncioService.create(anuncio, _listImages).then((value) {
      // novoAnuncio = value;
      Navigator.pop(context);
    });
  }

  @override
  void initState() {
    super.initState();
    _initEstados();
    _initCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Anúncio'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                    DropdownCustomWidget(
                      hint: 'Estado',
                      menuItens: _estadosDropItens,
                      currentValue: _currentValueEstado,
                      onChange: (currentValue) {
                        setState(() {
                          _currentValueEstado = currentValue;
                        });
                      },
                      onSaved: (value) {
                        anuncio.estado = value;
                      },
                      validator: RequiredValidatorCustomObject(
                          errorText: 'Campo obrigatório'),
                    ),
                    DropdownCustomWidget(
                      hint: 'Categoria',
                      menuItens: _categoriaDropItens,
                      currentValue: _currentValueCategoria,
                      onChange: (currentValue) {
                        setState(() {
                          _currentValueCategoria = currentValue;
                        });
                      },
                      onSaved: (value) {
                        anuncio.categoria = value;
                      },
                      validator: RequiredValidatorCustomObject(
                          errorText: 'Campo obrigatório'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormFieldCustomWidget(
                    hint: 'Título',
                    // controller: _tituloController,
                    onSaved: (value) {
                      anuncio.titulo = value;
                    },
                    validator:
                        RequiredValidator(errorText: 'Campo obrigatório'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormFieldCustomWidget(
                    hint: 'Preço',
                    type: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true)
                    ],
                    // controller: _tituloController,
                    onSaved: (value) {
                      anuncio.preco = value;
                    },
                    validator:
                        RequiredValidator(errorText: 'Campo obrigatório'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormFieldCustomWidget(
                    hint: 'Telefone',
                    // controller: _tituloController,
                    type: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                    onSaved: (value) {
                      anuncio.telefone = value;
                    },
                    validator:
                        RequiredValidator(errorText: 'Campo obrigatório'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormFieldCustomWidget(
                    hint: 'Descrição',
                    // controller: _tituloController,
                    maxLines: null,
                    onSaved: (value) {
                      anuncio.descricao = value;
                    },
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Campo obrigatório'),
                      MaxLengthValidator(200,
                          errorText: 'Máximo de 200 caractéres')
                    ]),
                  ),
                ),
                if (!isPressed)
                  BtnElevetedCustomWidget.defaultBtn(
                      text: 'Adicionar',
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          _saveAnuncio(context);
                        }
                      }),
                if (isPressed)
                  Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
