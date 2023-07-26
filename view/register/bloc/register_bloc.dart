import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:no_dr_detection_app/app/network/request.dart';
import 'package:no_dr_detection_app/app/network/storing_data.dart';
import 'package:no_dr_detection_app/app/network/uploading.dart';
import 'package:no_dr_detection_app/model/user_model.dart';

import '../../../app/network/auth.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  bool passwordSecure = true;
  bool confirmPasswordSecure = true;
  IconData passwordIconData = Icons.visibility;
  IconData confirmPasswordIconData = Icons.visibility;
  PlatformFile? pickedFile;
  String uId = "";
  String? urlImage;

  RegisterBloc() : super(RegisterInitial()) {
    on<ChangeVisibilityRegisterPassword>((event, emit) {
      passwordSecure = !passwordSecure;
      passwordIconData =
          passwordSecure ? Icons.visibility : Icons.visibility_off;
      emit(SuccessChangePasswordRegisterVisibility());
    });

    on<ChangeVisibilityRegisterConfirmPassword>((event, emit) {
      confirmPasswordSecure = !confirmPasswordSecure;
      confirmPasswordIconData =
          confirmPasswordSecure ? Icons.visibility : Icons.visibility_off;
      emit(SuccessChangeConfirmPasswordRegisterVisibility());
    });

    on<RemoveImageEvent>((event, emit) {
      if (pickedFile != null) {
        pickedFile = null;
        emit(RemoveImageState());
      }
    });

    on<SelectImageEvent>((event, emit) async {
      final result = await FilePicker.platform.pickFiles();
      if (result == null) return;
      pickedFile = result.files.first;
      emit(SelectImageState());
    });

    on<UploadingImageAndGetURLEvent>((event, emit) async {
      emit(LoadingUploading());
      urlImage = await UploadingImages.uploadImage(
          path: 'files',
          imageName: pickedFile!.name,
          pathFileImage: pickedFile!.path!);
      emit(SuccessUploading());
    });
    on<StoringUserDataEvent>((event, emit) async {
      final userModel = UserModel(
          firstName: event.userModel.firstName,
          lastName: event.userModel.lastName,
          image: urlImage,
          phone: event.userModel.phone,
          email: event.userModel.email);
      if (kDebugMode) {
        print(userModel);
      }
      await StoringData.createAndStoreCollectionWithData(
          collectionName: "users", json: userModel.toMap, uId: uId);
      emit(SuccessStoringUserData());
    });

    on<ConfirmUserEvent>(
      (event, emit) async {
        emit(LoadingConfirmUser());
        final requestAuth = await Authentication.signUp(
            requestSignUp:
                RequestSignUp(email: event.email, password: event.password));
        requestAuth.fold((failed) => emit(FailedConfirmUser(failed.message)),
            (success) async {
          uId = success.user!.uid;
          add(UploadingImageAndGetURLEvent());
          emit(SuccessConfirmUser());
        });
      },
    );
  }
}
