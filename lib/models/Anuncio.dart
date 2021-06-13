import 'dart:convert';

import 'package:olx_tequila/models/interfaces/Model.dart';

class Anuncio implements Model {
  String? _id;
  String? _estado;
  String? _categoria;
  String? _titulo;
  String? _preco;
  String? _telefone;
  String? _descricao;
  List<String>? _fotos;

  Anuncio({
    id,
    estado,
    categoria,
    titulo,
    preco,
    telefone,
    descricao,
    fotos,
  }) {
    this._id = id;
    this._estado = estado;
    this._categoria = categoria;
    this._titulo = titulo;
    this._preco = preco;
    this._telefone = telefone;
    this._descricao = descricao;
    this._fotos = fotos ?? [];
  }

  get id => this._id;
  get estado => this._estado;
  get categoria => this._categoria;
  get titulo => this._titulo;
  get preco => this._preco;
  get telefone => this._telefone;
  get descricao => this._descricao;
  get fotos => this._fotos;

  set id(value) => this._id = value;
  set estado(value) => this._estado = value;
  set categoria(value) => this._categoria = value;
  set titulo(value) => this._titulo = value;
  set preco(value) => this._preco = value;
  set telefone(value) => this._telefone = value;
  set descricao(value) => this._descricao = value;
  set fotos(value) => this._fotos = value;

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': _id,
      'estado': _estado,
      'categoria': _categoria,
      'titulo': _titulo,
      'preco': _preco,
      'telefone': _telefone,
      'descricao': _descricao,
      'fotos': _fotos,
    };
  }

  factory Anuncio.fromMap(Map<String, dynamic> map) {
    return Anuncio(
      id: map['id'],
      estado: map['estado'],
      categoria: map['categoria'],
      titulo: map['titulo'],
      preco: map['preco'],
      telefone: map['telefone'],
      descricao: map['descricao'],
      fotos: List<String>.from(map['fotos']),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Anuncio.fromJson(String source) =>
      Anuncio.fromMap(json.decode(source));
}
