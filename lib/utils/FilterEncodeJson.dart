import 'package:cloud_firestore/cloud_firestore.dart';

class FilterEncodeJson {
  static dynamic tratarData(dynamic item) {
    if (item is Timestamp) {
      return (item.toDate().toIso8601String());
    }
  }
}
