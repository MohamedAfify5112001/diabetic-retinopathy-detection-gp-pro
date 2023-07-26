import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:no_dr_detection_app/model/history_data.dart';

import '../../../app/caching/cache_helper.dart';
import '../../../app/core/constants/constants_app.dart';
import '../../../app/network/crud_operation.dart';
import '../../../app/network/uploading.dart';

part 'edit_event.dart';

part 'edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  PlatformFile? pickedFile;
  String? urlImage;

  EditBloc() : super(EditInitial()) {
    on<RemoveEditImageEvent>((event, emit) {
      if (pickedFile != null) {
        pickedFile = null;
        urlImage = null;
        emit(RemoveEditingImageState());
      }
    });

    on<UploadingEditImageAndGetURLEvent>((event, emit) async {
      if (pickedFile != null) {
        emit(LoadingEditingImageUploading());
        urlImage = await UploadingImages.uploadImage(
            path: 'files',
            imageName: pickedFile!.name,
            pathFileImage: pickedFile!.path!);
        emit(SuccessEditingImageUploading());
      }
    });
    on<EditPatientRecordEvent>(_onEditRecordPatient);
    on<SelectEditImageEvent>(_onSelectEditingImage);
  }

  Future<void> _onSelectEditingImage(
      SelectEditImageEvent event, Emitter<EditState> emit) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    pickedFile = result.files.first;
    emit(SelectEditingImageState());
  }

  Future<void> _onEditRecordPatient(
      EditPatientRecordEvent event, Emitter<EditState> emit) async {
    emit(LoadingUpdatePatientRecord());
    try {
      final historyModel = HistoryModel(
          uId: event.historyModel.uId,
          patientName: event.historyModel.patientName,
          stage: event.historyModel.stage,
          image: event.historyModel.image,
          patientsAge: event.historyModel.patientsAge,
          treatment: event.historyModel.treatment,
          treatmentDuration: event.historyModel.treatmentDuration,
          drugs: event.historyModel.drugs,
          timeOfConsultation: event.historyModel.timeOfConsultation);
      await CrudOperation.updateHistoryData(
          uId: event.historyModel.uId,
          firebaseUserId:
              CacheHelper.getValue(key: AppConstants.MYUID).toString(),
          collectionName: "users",
          subCollection: "history",
          historyModel: historyModel);
      if (kDebugMode) {
        print(historyModel);
      }
      emit(SuccessUpdatePatientRecord());
    } on FirebaseException catch (error) {
      emit(FailureUpdatePatientRecord());
    }
  }
}
