import 'package:no_dr_detection_app/app/network/failure.dart';

enum SignUpError { weakPassword, emailAlreadyInUse, unKnownError }

enum SignInError { userNotFound, wrongPassword }

extension SignUpErrorMethods on SignUpError {
  Failure get getError {
    switch (this) {
      case SignUpError.weakPassword:
        return WeakPasswordFailure(
            message: 'The password provided is too weak.');
      case SignUpError.emailAlreadyInUse:
        return EmailIsUsedFailure(
            message: 'The account already exists for that email.');
      case SignUpError.unKnownError:
        return UnKnownError(message: 'Unknown Error.');
    }
  }
}

extension SignInErrorMethods on SignInError {
  Failure get getError {
    switch (this) {
      case SignInError.userNotFound:
        return UserNotFoundFailure(message: 'No user found for that email.');
      case SignInError.wrongPassword:
        return WrongPasswordFailure(
            message: 'Wrong password provided for that user.');
    }
  }
}
