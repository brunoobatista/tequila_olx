import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olx_tequila/models/Anuncio.dart';
import 'package:olx_tequila/modelview/UserTequila.dart';
import 'package:olx_tequila/repositories/AnuncioRepository.dart';
import 'package:olx_tequila/repositories/FirebaseAuthRepository.dart';
import 'package:olx_tequila/repositories/FirebaseDBRepository.dart';
import 'package:olx_tequila/repositories/StorageRepository.dart';

class AnuncioService {
  StorageRepository _storage = StorageRepository();
  FirebaseDBRepository _dbRepository = FirebaseDBRepository();
  FirebaseAuthRepository auth = FirebaseAuthRepository();
  AnuncioRepository _repository = AnuncioRepository();

  final String collection = 'anuncios';

  Future<Anuncio> create(Anuncio anuncio, List<File> listImages) async {
    UserTequila user = await auth.getCurrentUser();
    if (!user.isLogged) throw Exception('Usuário precisa estar logado');
    anuncio.id = _dbRepository.createIdTemp(
      collection: collection,
      docChild: user.getId,
      collChild: 'meus_anuncios',
    );
    List<String> links = await _storage.uploadFiles(
        images: listImages, path: collection, subPath: anuncio.id);

    anuncio.fotos = links;
    await _repository.save(
      anuncio: anuncio,
      idUser: user.getId,
    );

    return anuncio;
  }

  Future<bool> remove(Anuncio anuncio) async {
    UserTequila user = await auth.getCurrentUser();
    await _repository.remove(anuncio, user.id);

    return true;
  }

  getAnuncios({
    required Function(QuerySnapshot) fn,
    String? regiao,
    String? categoria,
  }) async {
    await _repository.getAnuncios(fn: fn, regiao: regiao, categoria: categoria);
  }

  Future<List<Anuncio>> getMeusAnuncios() async {
    UserTequila user = await auth.getCurrentUser();
    List<Anuncio> anuncios =
        await _repository.getAnunciosByUser(idUser: user.id);
    return anuncios;
  }
}
