abstract class Failure {
  final String message;

  Failure({required this.message});
}

class WeakPasswordFailure extends Failure {
  WeakPasswordFailure({required super.message});
}

class EmailIsUsedFailure extends Failure {
  EmailIsUsedFailure({required super.message});
}

class UnKnownError extends Failure {
  UnKnownError({required super.message});
}

class UserNotFoundFailure extends Failure {
  UserNotFoundFailure({required super.message});
}

class WrongPasswordFailure extends Failure {
  WrongPasswordFailure({required super.message});
}
class GoogleSignInFailure extends Failure{
  GoogleSignInFailure({required super.message});
}
