import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:no_dr_detection_app/app/network/request.dart';
import 'package:no_dr_detection_app/app/network/storing_data.dart';

import '../../../app/network/auth.dart';
import '../../../model/user_model.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  IconData iconData = Icons.visibility;
  bool isSecure = true;

  LoginBloc() : super(LoginInitial()) {
    on<ChangeVisibilityEvent>((event, emit) {
      isSecure = !isSecure;
      iconData = isSecure ? Icons.visibility : Icons.visibility_off;
      emit(SuccessChangeVisibility());
    });

    on<LoginInEvent>((event, emit) async {
      emit(LoadingLogin());
      final loginReq =
          await Authentication.signIn(requestSignIn: event.requestSignIn);
      loginReq.fold((fail) => emit(FailureLogin(fail.message)), (success) {
        emit(SuccessLogin(success.user!.uid));
      });
    });

    on<GoogleLoginInEvent>(_onGoogleLogin);
    on<StoringGoogleUserEvent>(_onStoreGoogleUser);
  }

  Future<void> _onGoogleLogin(
      GoogleLoginInEvent event, Emitter<LoginState> emit) async {
    emit(LoadingLoginGoogle());
    final userGoogle = await Authentication.signInWithGoogle();
    userGoogle.fold((fail) => emit(FailureLoginGoogle(fail.message)),
        (user) => emit(SuccessLoginGoogle(user)));
  }

  Future<void> _onStoreGoogleUser(
      StoringGoogleUserEvent event, Emitter<LoginState> emit) async {
    final userModel = UserModel(
        firstName: event.userModel.firstName,
        lastName: event.userModel.lastName,
        image: event.userModel.image,
        phone: event.userModel.phone,
        email: event.userModel.email);
    if (kDebugMode) {
      print("Googleeeeeeeeeeeeeeeeee $userModel");
    }
    await StoringData.createAndStoreCollectionWithData(
        collectionName: "users", json: userModel.toMap, uId: event.uId);
    emit(StoreGoogleUserState());
  }
}
