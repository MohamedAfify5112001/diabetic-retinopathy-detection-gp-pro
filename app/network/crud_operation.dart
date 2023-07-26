import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:no_dr_detection_app/model/history_data.dart';

class CrudOperation {
  static Future<Map<String, dynamic>> readOperation(
      {required String firebaseUserId, required String collectionName}) async {
    final DocumentSnapshot<Map<String, dynamic>> getData = await FirebaseFirestore
        .instance
        .collection(collectionName)
        .doc(firebaseUserId) // changed to .doc because .document is deprecated
        .get();
    final Map<String, dynamic> getSpecificData = getData.data() ?? {};
    if (kDebugMode) {
      print(getSpecificData);
    }
    return getSpecificData;
  }

  static Future<void> updateHistoryData(
      {required String uId,
      required String firebaseUserId,
      required String collectionName,
      required String subCollection,
      required HistoryModel historyModel}) async {
    // Get a reference to the document you want to update
    final docRef = FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollection)
        .doc(uId);
    await docRef.update(historyModel.toMap());
  }

  static Future<List<HistoryModel>> readHistoryData(
      {required String firebaseUserId,
      required String collectionName,
      required String subCollection}) async {
    var query = await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollection)
        .get();
    // final List<HistoryModel> historyModelItems =
    //     query.docs.map((history) => HistoryModel.fromMap(history)).toList();
    final historyItemsJson = query.docs.map((data) => data.data()).toList();
    List<String> uIds = query.docs.map((id) => id.id).toList();
    List<JsonMap> historyJsonsWithUId = [];
    List<HistoryModel> historyModelItems = [];

    for (int i = 0; i < historyItemsJson.length; i++) {
      JsonMap jsonNewProduct = historyItemsJson[i];
      jsonNewProduct['uId'] = uIds[i];
      historyJsonsWithUId.add(jsonNewProduct);
    }
    historyModelItems =
        historyJsonsWithUId.map((e) => HistoryModel.fromMap(e)).toList();
    return historyModelItems;
  }

  static Future<void> deleteHistory(
      {required String uId,
      required String firebaseUserId,
      required String collectionName,
      required String subCollection}) async {
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(firebaseUserId)
        .collection(subCollection)
        .doc(uId)
        .delete();
  }
}

typedef JsonMap = Map<String, dynamic>;
