import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:olx_tequila/models/Categoria.dart';
import 'package:olx_tequila/models/interfaces/Model.dart';

class FirebaseDBRepository {
  FirebaseFirestore _db = FirebaseFirestore.instance;

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
    required Model model,
    required String collection,
    required String idOwner,
    String? collChild,
    String? docChild,
  }) async {
    try {
      DocumentReference docRef = _db.collection(collection).doc(idOwner);
      if (collChild != null) {
        if (docChild == null)
          throw Exception('É necessário informar o docChild');
        docRef = docRef.collection(collChild).doc(docChild);
      }
      await docRef.set(model.toMap());
    } on FirebaseException catch (e) {
      throw e.toString();
    } on Exception catch (e) {
      throw e.toString();
    }
  }

  Future<List<Categoria>> getCategorias() async {
    QuerySnapshot snapshot = await _db.collection('categorias').get();

    List<Categoria> categorias = [];
    for (DocumentSnapshot item in snapshot.docs.toList()) {
      var dados = item.data() as Map<String, dynamic>;
      categorias.add(Categoria.fromMap(dados));
    }

    return categorias;
  }
}
