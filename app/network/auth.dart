import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:no_dr_detection_app/app/network/failure.dart';
import 'package:no_dr_detection_app/app/network/request.dart';

import '../core/enum/failure_enum.dart';

abstract class Authentication {
  static Future<Either<Failure, UserCredential>> signIn(
      {required RequestSignIn requestSignIn}) async {
    String code = "";
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: requestSignIn.email, password: requestSignIn.password);
    } on FirebaseAuthException catch (e) {
      code = e.code;
    }
    if (code == 'user-not-found') {
      return Left(SignInError.userNotFound.getError);
    } else if (code == 'wrong-password') {
      return Left(SignInError.wrongPassword.getError);
    } else {
      return Right(credential!);
    }
  }

  static Future<Either<Failure, UserCredential>> signInWithGoogle() async {
    try {
      final FirebaseAuth auth = FirebaseAuth.instance;
      final GoogleSignIn googleSignIn = GoogleSignIn();
      // Trigger the Google authentication flow.
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      // Obtain the auth details from the Google login.
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;

      // Create a new credential.
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      return Right(userCredential);
    } on FirebaseAuthException catch (error) {
      return Left(GoogleSignInFailure(message: error.message!));
    }
  }

  static Future<Either<Failure, UserCredential>> signUp(
      {required RequestSignUp requestSignUp}) async {
    String code = "";
    UserCredential? credential;
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: requestSignUp.email, password: requestSignUp.password);
    } on FirebaseAuthException catch (e) {
      code = e.code;
    }
    if (code.isNotEmpty) {
      if (code == 'weak-password') {
        return Left(SignUpError.weakPassword.getError);
      } else if (code == 'email-already-in-use') {
        return Left(SignUpError.emailAlreadyInUse.getError);
      } else {
        return Left(SignUpError.unKnownError.getError);
      }
    } else {
      return Right(credential!);
    }
  }
}
