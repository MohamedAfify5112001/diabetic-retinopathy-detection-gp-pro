import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class UploadingImages {
  static Future<String> uploadImage(
      {required String path,
      required String imageName,
      required String? pathFileImage}) async {
    // String urlDownload = "";
    final pathImages = "$path/$imageName";
    final file = File(pathFileImage ?? "");
    final ref = FirebaseStorage.instance.ref().child(pathImages);
    final uploadTask = ref.putFile(file);
    // uploadTask.then(
    //     (p0) => p0.ref.getDownloadURL().then((value) => urlDownload = value));
    final snapshot = await uploadTask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print("My IMAGE $urlDownload");
    }
    return urlDownload.toString();
  }
}
