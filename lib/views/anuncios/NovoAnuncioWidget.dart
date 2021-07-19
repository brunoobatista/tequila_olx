import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:olx_tequila/core/AppPadding.dart';
import 'package:olx_tequila/models/Anuncio.dart';
import 'package:olx_tequila/services/AnuncioService.dart';
import 'package:olx_tequila/utils/AuxFunction.dart';
import 'package:olx_tequila/utils/Converter.dart';
import 'package:olx_tequila/utils/InitDropdown.dart';
import 'package:olx_tequila/utils/validators/RequiredValidatorCustomObject.dart';
import 'package:olx_tequila/views/anuncios/widgets/ListViewCustomWidget.dart';
import 'package:olx_tequila/views/widgets/BtnElevetedCustomWidget.dart';
import 'package:olx_tequila/views/widgets/DropdownCustomWidget.dart';
import 'package:olx_tequila/views/widgets/TextFormFieldCustomWidget.dart';

class NovoAnuncioWidget extends StatefulWidget {
  final AuxFunction functionAux = AuxFunction(voidCallback: () {});
  NovoAnuncioWidget({Key? key, Object? function}) {
    AuxFunction aux = function as AuxFunction;
    if (aux.voidCallback is Function) {
      this.functionAux.setNewFn(aux.currentFn);
    }
    // var args = this.functionAux as Map;
    // this.function = args['function'];
  }

  @override
  _NovoAnuncioWidgetState createState() => _NovoAnuncioWidgetState();
}

class _NovoAnuncioWidgetState extends State<NovoAnuncioWidget> {
  final _formKey = GlobalKey<FormState>();
  final List<File> _listImages = [];
  final InitDropdown _initDropdown = InitDropdown();
  List<DropdownMenuItem<String>> _estadosDropItens = [];
  List<DropdownMenuItem<String>> _categoriaDropItens = [];

  final AnuncioService _anuncioService = AnuncioService();
  final anuncio = Anuncio();
  bool isPressed = false;
  String? _currentValueEstado;
  String? _currentValueCategoria;

  _initDrops() async {
    var cats = await this._initDropdown.initCategorias();
    setState(() {
      this._estadosDropItens = this._initDropdown.initEstados();
      this._categoriaDropItens = cats;
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
      widget.functionAux.voidCallback!();
    });
  }

  @override
  void initState() {
    super.initState();
    _initDrops();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                          ),
                        ),
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
                    Expanded(
                      child: DropdownCustomWidget(
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
                    ),
                    Expanded(
                      child: DropdownCustomWidget(
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
