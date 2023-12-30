import 'package:chathub/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProviders extends ChangeNotifier {
  Future<UserCredential>? user;
  AuthService authservice = AuthService();
  signInWithEmail(String email, String password, BuildContext context) {
    return authservice.signInWithEmail(email, password, context);
  }

  signUpWithEmail(String email, String password, String name) {
    return authservice.signUpWithEmail(email, password, name);
  }

  singupWithGoogle() {
    return authservice.singinWithGoogle();
  }

  signInWithGithub(context) {
    return authservice.signInWithGithub(context);
  }
}
