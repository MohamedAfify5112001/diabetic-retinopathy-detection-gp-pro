part of 'register_bloc.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class SuccessChangePasswordRegisterVisibility extends RegisterState {}

class SuccessChangeConfirmPasswordRegisterVisibility extends RegisterState {}

class SelectImageState extends RegisterState {}

class SuccessConfirmUser extends RegisterState {}

class LoadingConfirmUser extends RegisterState {}

class FailedConfirmUser extends RegisterState {
  final String msg;

  FailedConfirmUser(this.msg);
}

class LoadingUploading extends RegisterState {}

class SuccessUploading extends RegisterState {}

class SuccessStoringUserData extends RegisterState {}

class RemoveImageState extends RegisterState{}
