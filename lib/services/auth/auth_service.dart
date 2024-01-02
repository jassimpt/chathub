import 'package:chathub/models/user_model.dart';
import 'package:chathub/views/loginscreen/widgets/custom_alert_dialoge.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithEmail(
      String email, String pass, context) async {
    try {
      UserCredential user =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      return user;
    } on FirebaseAuthException catch (e) {
      String errorcode = "error singIn";
      if (e.code == 'wrong-password' || e.code == 'user-not-found') {
        errorcode = "Icorrect email or password";
      } else if (e.code == 'user-disabled') {
        errorcode = "User not found";
      } else {
        errorcode = e.code;
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(errorcode)));
      return null;
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

  void signInwithPhone(
      String phonenumber, context, String name, String email) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phonenumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            var cred = await auth.signInWithCredential(phoneAuthCredential);
            final UserModel userdata = UserModel(
                email: email,
                name: name,
                uid: cred.user!.uid,
                phonenumber: cred.user!.phoneNumber);
            firestore
                .collection("users")
                .doc(cred.user!.uid)
                .set(userdata.toJson());
          },
          verificationFailed: (error) {
            throw Exception(error.message);
          },
          codeSent: (verificationId, resendtoken) {
            showDialog(
              context: context,
              builder: (context) {
                return CustomAlertDialog(
                  veridicationId: verificationId,
                );
              },
            );
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  void verifyOtp(
      {required String verificationId,
      required String otp,
      required Function onSuccess}) async {
    try {
      PhoneAuthCredential cred = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: otp);
      User? user = (await auth.signInWithCredential(cred)).user;

      if (user != null) {
        onSuccess();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  signInWithGithub(context) async {
    GithubAuthProvider githubAuthProvider = GithubAuthProvider();
    try {
      UserCredential user = await auth.signInWithProvider(githubAuthProvider);
      User gituser = user.user!;
      final UserModel userdata = UserModel(
          email: gituser.email, name: gituser.displayName, uid: gituser.uid);
      firestore.collection("users").doc(gituser.uid).set(userdata.toJson());
      return user;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
      throw Exception(e);
    }
  }

  Future<void> signOut() async {
    final GoogleSignIn google = GoogleSignIn();

    try {
      await auth.signOut();
      await google.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

  void passwordReset({required email, context}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password reset email sent")));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
}
