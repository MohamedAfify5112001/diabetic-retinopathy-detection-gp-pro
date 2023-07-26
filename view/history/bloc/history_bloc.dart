import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:no_dr_detection_app/app/network/crud_operation.dart';
import 'package:no_dr_detection_app/model/history_data.dart';

import '../../../app/caching/cache_helper.dart';
import '../../../app/core/constants/constants_app.dart';
import '../../../app/network/storing_data.dart';
import '../../../app/network/uploading.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  String urlImage = "";
  List<HistoryModel> historyItems = [];

  HistoryBloc() : super(HistoryInitial()) {
    on<ReturnHistoryRecordButtonEvent>(
        (event, emit) => emit(ReturnInitialStateHistory()));

    on<UploadImageHistoryData>((event, emit) async {
      emit(LoadingUploadImageHistory());
      try {
        urlImage = await UploadingImages.uploadImage(
            path: 'files',
            imageName: event.platformFile.name,
            pathFileImage: event.platformFile.path);
        print("LEHHHHHHHHHHHHHHHHHHHHHH KEDA BS $urlImage");
        emit(SuccessUploadImageHistory());
      } catch (error) {
        emit(FailedUploadImageHistory());
      }
    });

    on<SavedHistoryData>((event, emit) async {
      emit(LoadingSavingDataHistory());
      try {
        await StoringData.createAndStoreSubCollectionWithData(
            subCollectionName: "history",
            collectionName: "users",
            userUId: CacheHelper.getValue(key: AppConstants.MYUID).toString(),
            json: event.historyModel.toMap());
        print("LEHHHHHHHHHHHHHHHHHHHHHH $urlImage");
        emit(SuccessSavingDataHistory());
      } catch (error) {
        emit(FailedSavingDataHistory());
      }
    });
    on<GetHistoryDataEvent>((event, emit) async {
      emit(LoadingGetDataHistory());
      try {
        historyItems = await CrudOperation.readHistoryData(
            firebaseUserId:
                CacheHelper.getValue(key: AppConstants.MYUID).toString(),
            collectionName: "users",
            subCollection: "history");
        if (historyItems.isNotEmpty) {
          log('UIIIIIIIIIIIID${historyItems[0].uId}');
          emit(SuccessGetDataHistory());
        } else {
          emit(EmptyDataHistory());
        }
      } catch (error) {
        print("Errrrrrrrrrrrrrrrrrrrrrro $error");
        emit(FailedGetDataHistory());
      }
    });
    on<DeletingHistoryEvent>(_onDeleteHistory);
  }

  Future<void> _onDeleteHistory(
      DeletingHistoryEvent event, Emitter<HistoryState> emit) async {
    try {
      await CrudOperation.deleteHistory(
          uId: event.uId,
          firebaseUserId:
              CacheHelper.getValue(key: AppConstants.MYUID).toString(),
          collectionName: "users",
          subCollection: "history");
      final List<HistoryModel> historyItemsAfterDeleted =
          await CrudOperation.readHistoryData(
              firebaseUserId:
                  CacheHelper.getValue(key: AppConstants.MYUID).toString(),
              collectionName: "users",
              subCollection: "history");
      emit(SuccessDeleteHistory(historyItemsAfterDeleted));
    } on FirebaseException catch (error) {
      emit(FailureDeleteHistory());
    }
  }
}
