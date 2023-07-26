part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class SuccessChangeVisibility extends LoginState {}

class SuccessLogin extends LoginState {
  final String uId;

  SuccessLogin(this.uId);
}

class FailureLogin extends LoginState {
  final String msg;

  FailureLogin(this.msg);
}

class LoadingLogin extends LoginState {}

class SuccessLoginGoogle extends LoginState {
  final UserCredential userGoogle;

  SuccessLoginGoogle(this.userGoogle);
}

class FailureLoginGoogle extends LoginState {
  final String msg;

  FailureLoginGoogle(this.msg);
}

class LoadingLoginGoogle extends LoginState {}

class StoreGoogleUserState extends LoginState {}
