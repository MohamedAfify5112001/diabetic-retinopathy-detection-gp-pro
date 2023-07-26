part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class ChangeVisibilityEvent extends LoginEvent {}

class LoginInEvent extends LoginEvent {
  final RequestSignIn requestSignIn;

  LoginInEvent(this.requestSignIn);
}

class GoogleLoginInEvent extends LoginEvent {}

class StoringGoogleUserEvent extends LoginEvent {
  final String uId;
  final UserModel userModel;

  StoringGoogleUserEvent({
    required this.uId,
    required this.userModel,
  });
}
