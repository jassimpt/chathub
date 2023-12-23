import 'package:chathub/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var verifyid = "";

  Future<UserCredential> signInWithEmail(String email, String pass) async {
    try {
      UserCredential user =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signUpWithEmail(
    String email,
    String pass,
    String name,
  ) async {
    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      final UserModel userdata =
          UserModel(email: email, name: name, uid: user.user!.uid);

      firestore.collection('users').doc(user.user!.uid).set(userdata.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  singinWithGoogle() async {
    try {
      final GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gauth = await guser!.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: gauth.accessToken, idToken: gauth.idToken);
      UserCredential user = await auth.signInWithCredential(credential);
      User? googleuser = user.user;
      final UserModel userdata = UserModel(
          email: googleuser!.email,
          name: googleuser.displayName,
          uid: googleuser.uid);
      firestore.collection("users").doc(googleuser.uid).set(userdata.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  signInWithPhone(
      String phonenumber, context, String name, String email) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phonenumber,
      verificationCompleted: (phoneAuthCredential) async {
        UserCredential user =
            await auth.signInWithCredential(phoneAuthCredential);
        final UserModel userdata = UserModel(
            email: email,
            name: name,
            uid: user.user!.uid,
            phonenumber: user.user!.phoneNumber);
        firestore
            .collection("users")
            .doc(user.user!.uid)
            .set(userdata.toJson());
      },
      verificationFailed: (e) {
        if (e.code == "invalid-phone-number") {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('invalid phone number')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Oops,something went wrong checkback later')));
          throw Exception(e.code);
        }
      },
      codeSent: (verificationId, resendToken) {
        verifyid = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        verifyid = verificationId;
      },
    );
  }

  verifyOtp(String otp) async {
    try {
      var credential = await auth.signInWithCredential(
          PhoneAuthProvider.credential(verificationId: verifyid, smsCode: otp));
      return credential.user != null ? true : false;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException occurred: ${e.message}");
      throw e;
    }
  }

  Future<void> signOut() async {
    final GoogleSignIn google = GoogleSignIn();
    try {
      await google.signOut();
      await auth.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
