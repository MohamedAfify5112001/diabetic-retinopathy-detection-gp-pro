import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:tflite/tflite.dart';

part 'checking_your_self_event.dart';

part 'checking_your_self_state.dart';

class CheckingYourSelfBloc
    extends Bloc<CheckingYourSelfEvent, CheckingYourSelfState> {
  PlatformFile? pickedFile;
  List<dynamic> predictModel = [];

  CheckingYourSelfBloc() : super(CheckingYourSelfInitial()) {
    on<UploadDRImageEvent>((event, emit) async {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      pickedFile = result.files.first;
      emit(UploadDRImageState());
    });
    on<RemoveDRImageEvent>((event, emit) {
      if (pickedFile != null) {
        pickedFile = null;
        emit(RemoveDRImageState());
      }
    });
    on<LoadingModelEvent>((event, emit) async {
      await Future.wait([
        Tflite.loadModel(
          model: "assets/model/99_saved_model_eff.tflite",
          labels: "assets/model/labels.txt",
        )
      ]);

      emit(SuccessLoadingModelState());
    });
    on<ClassifyImageByModelEvent>((event, emit) async {
      var output = await Tflite.runModelOnImage(
        path: pickedFile!.path!,
        numResults: 6,
        threshold: 0.5,
        imageMean: 0,
        imageStd: 1,
      );
      predictModel = output!;
      if (kDebugMode) {
        print("MY $output");
      }
      emit(SuccessClassifyImageState());
    });
    on<RemovePredictionEvent>((event, emit) {
      predictModel = [];
      emit(RemovePredictionState());
    });
  }
}
