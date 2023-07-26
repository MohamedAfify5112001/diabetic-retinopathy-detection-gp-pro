part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class ChangeVisibilityRegisterPassword extends RegisterEvent {}

class ChangeVisibilityRegisterConfirmPassword extends RegisterEvent {}

class SelectImageEvent extends RegisterEvent {}

class ConfirmUserEvent extends RegisterEvent {
  final String password;
  final String email;

  ConfirmUserEvent(this.email, this.password);
}

class UploadingImageAndGetURLEvent extends RegisterEvent {}

class StoringUserDataEvent extends RegisterEvent {
  final UserModel userModel;

  StoringUserDataEvent(this.userModel);
}

class RemoveImageEvent extends RegisterEvent {}
