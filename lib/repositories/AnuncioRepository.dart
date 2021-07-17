import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olx_tequila/models/Anuncio.dart';
import 'package:olx_tequila/repositories/FirebaseDBRepository.dart';
import 'package:olx_tequila/repositories/StorageRepository.dart';
import 'package:olx_tequila/utils/FilterEncodeJson.dart';

class AnuncioRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  StorageRepository _storage = StorageRepository();
  FirebaseDBRepository _firebaseDBRepository = FirebaseDBRepository();
  String collection = 'anuncios';
  String myAnnouncement = 'meus_anuncios';
  String createIdTemp({
    required String collection,
    String? collChild,
    String? docChild,
  }) {
    CollectionReference colref = _db.collection(collection);
    if (docChild != null) {
      if (collChild == null)
        throw Exception('É necessário informar o collChild');
      colref = colref.doc(docChild).collection(collChild);
    }
    return colref.doc().id;
  }

  Future save({
    required Anuncio anuncio,
    required String idUser,
  }) async {
    String anuncioId;
    String idAnuncUser;
    try {
      anuncioId = _firebaseDBRepository.createIdTemp(
        collection: collection,
      );
      anuncio.id = anuncioId;
      DocumentReference docRef = _db.collection(collection).doc(anuncio.id);
      await docRef.set(anuncio.toMap());
      DocumentReference docRefAnuncUser =
          await this.saveForUser(idAnuncio: anuncioId, idUser: idUser);
      idAnuncUser = docRefAnuncUser.id;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<DocumentReference> saveForUser({
    required String idAnuncio,
    required String idUser,
  }) async {
    try {
      DocumentReference docRef = _db
          .collection(myAnnouncement)
          .doc(idUser)
          .collection(collection)
          .doc(idAnuncio);
      await docRef.set(Map<String, dynamic>());
      return docRef;
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<bool> remove(Anuncio anuncio, String idUser) async {
    try {
      await _db.collection(collection).doc(anuncio.id).delete();
      await _db
          .collection(myAnnouncement)
          .doc(idUser)
          .collection(collection)
          .doc(anuncio.id)
          .delete();
    } on Exception catch (e) {
      throw e.toString();
    }
    return true;
  }

  Future<List<Anuncio>> getAnunciosByUser({required String idUser}) async {
    List<Anuncio> anuncios = [];
    QuerySnapshot snapshot = await _db
        .collection(myAnnouncement)
        .doc(idUser)
        .collection(collection)
        .get();

    List<String> ids = [];

    for (DocumentSnapshot doc in snapshot.docs) {
      ids.add(doc.id);
    }
    if (ids.isNotEmpty) {
      QuerySnapshot anunciosSnap =
          await _db.collection(collection).where('id', whereIn: ids).get();

      for (DocumentSnapshot doc in anunciosSnap.docs) {
        var dado = doc.data();
        Anuncio anuncio = Anuncio.fromJson(
            jsonEncode(dado, toEncodable: FilterEncodeJson.tratarData));
        anuncios.add(anuncio);
      }
    }
    return anuncios;
  }

  getAnuncios({
    required Function(QuerySnapshot) fn,
    String? regiao,
    String? categoria,
  }) {
    Query query =
        _db.collection(collection).orderBy('created_at', descending: true);

    if (regiao != null) {
      query = query.where('estado', isEqualTo: regiao);
    }
    if (categoria != null) {
      query = query.where('categoria', isEqualTo: categoria);
    }

    Stream<QuerySnapshot> stream = query.snapshots();
    stream.listen((event) {
      fn(event);
    });
  }
}
