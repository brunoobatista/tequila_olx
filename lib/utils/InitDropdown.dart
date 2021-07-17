import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:olx_tequila/core/AppColors.dart';
import 'package:olx_tequila/models/Categoria.dart';
import 'package:olx_tequila/repositories/FirebaseDBRepository.dart';

class InitDropdown {
  final List<DropdownMenuItem<String>> _estadosDropItens = [];
  final List<DropdownMenuItem<String>> _categoriaDropItens = [];
  final FirebaseDBRepository firebaseRepository = FirebaseDBRepository();

  initEstados() {
    _estadosDropItens.add(
      DropdownMenuItem(
        child: Text(
          'Região',
          style: TextStyle(color: AppColors.sDeepPurpleLight),
        ),
        value: null,
      ),
    );
    Estados.listaEstadosSigla.asMap().forEach((key, value) {
      _estadosDropItens.add(
        DropdownMenuItem(
          child: Text(value),
          value: value,
        ),
      );
    });
    return this._estadosDropItens;
  }

  initCategorias() async {
    List<Categoria> categorias = await firebaseRepository.getCategorias();
    _categoriaDropItens.add(
      DropdownMenuItem(
        child: Text(
          'Categoria',
          style: TextStyle(color: AppColors.sDeepPurpleLight),
        ),
        value: null,
      ),
    );
    categorias.asMap().forEach((key, categoria) {
      _categoriaDropItens.add(
        DropdownMenuItem(
          child: Text(categoria.label),
          value: categoria.value,
        ),
      );
    });
    return this._categoriaDropItens;
  }
}
