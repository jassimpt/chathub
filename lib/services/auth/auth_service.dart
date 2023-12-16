import 'package:chathub/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
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

  Future<void> signOut() {
    return auth.signOut();
  }
}
