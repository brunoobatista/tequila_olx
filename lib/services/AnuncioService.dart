import 'dart:io';

import 'package:olx_tequila/models/Anuncio.dart';
import 'package:olx_tequila/modelview/UserTequila.dart';
import 'package:olx_tequila/repositories/FirebaseAuthRepository.dart';
import 'package:olx_tequila/repositories/FirebaseDBRepository.dart';
import 'package:olx_tequila/repositories/StorageRepository.dart';

class AnuncioService {
  StorageRepository _storage = StorageRepository();
  FirebaseDBRepository _db = FirebaseDBRepository();
  FirebaseAuthRepository auth = FirebaseAuthRepository();

  final String collection = 'anuncios';

  Future<Anuncio> create(Anuncio anuncio, List<File> listImages) async {
    UserTequila user = await auth.getCurrentUser();
    if (!user.isLogged) throw Exception('Usuário precisa estar logado');
    anuncio.id = _db.createIdTemp(
      collection: collection,
      docChild: user.getId,
      collChild: 'meus_anuncios',
    );
    List<String> links = await _storage.uploadFiles(
        images: listImages, path: collection, subPath: anuncio.id);

    anuncio.fotos = links;
    await _db.save(
      model: anuncio,
      collection: 'anuncios',
      idOwner: user.getId,
      collChild: 'meus_anuncios',
      docChild: anuncio.id,
    );
    return anuncio;
  }
}
