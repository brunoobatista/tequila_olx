import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<String>> uploadFiles(
      {required List<File> images,
      required String path,
      String? subPath}) async {
    Reference rootFolder = _storage.ref();
    List<String> links = [];

    for (var image in images) {
      String nameImage = DateTime.now().millisecondsSinceEpoch.toString();
      Reference fileDir = rootFolder.child(path);
      if (subPath != null) fileDir = fileDir.child(subPath);
      fileDir = fileDir.child(nameImage);
      UploadTask task = fileDir.putFile(image);

      StreamSubscription sub =
          task.snapshotEvents.listen((TaskSnapshot snapshot) async {
        if (snapshot.state == TaskState.running) {
          print(
              'Progress: ${(snapshot.bytesTransferred / snapshot.totalBytes) * 100} %');
        } else if (snapshot.state == TaskState.success) {
          print("Salvo... -> ");
        }
      });
      TaskSnapshot snapshot = await task;
      String url = await snapshot.ref.getDownloadURL();
      links.add(url);
      sub.cancel();
    }

    return links;
  }
}
