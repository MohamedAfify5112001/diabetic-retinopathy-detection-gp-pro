class AuthRequests {
  final String email;
  final String password;

  AuthRequests({required this.email, required this.password});
}

class RequestSignUp extends AuthRequests {
  RequestSignUp({required super.email, required super.password});
}

class RequestSignIn extends AuthRequests {
  RequestSignIn({required super.email, required super.password});
}
