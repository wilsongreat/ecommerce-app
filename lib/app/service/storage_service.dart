import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final String uid;

  StorageService({required this.uid});

  FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> uploadFiles(String filePath) async {
    try {
      final dateTime = DateTime.now().toIso8601String();
      var ref = storage.ref("$uid/$dateTime");
      final uploadTask = await ref.putFile(File(filePath));
      return await uploadTask.ref.getDownloadURL();
    } catch (e) {
      print('error Occured');
    }
    return "";
  }
}
