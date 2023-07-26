import 'package:cloud_firestore/cloud_firestore.dart';

class StoringData {
  static Future<void> createAndStoreCollectionWithData(
      {required String collectionName,
      required Map<String, dynamic> json,
      String? uId}) async {
    final docItem = (uId == null)
        ? FirebaseFirestore.instance.collection(collectionName).doc()
        : FirebaseFirestore.instance.collection(collectionName).doc(uId);
    await docItem.set(json);
  }

  static Future<void> createAndStoreSubCollectionWithData(
      {required String collectionName,
      required String subCollectionName,
      required Map<String, dynamic> json,
      required String userUId}) async {
    final docItem = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(userUId)
        .collection(subCollectionName);
    await docItem.add(json);
  }
}
