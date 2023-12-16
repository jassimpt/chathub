import 'package:chathub/models/user_model.dart';
import 'package:chathub/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier {
  List<UserModel> users = [];
  AuthService service = AuthService();
  List<UserModel> getAllUsers() {
    service.firestore
        .collection('users')
        .snapshots(includeMetadataChanges: true)
        .listen((user) {
      users = user.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      notifyListeners();
    });
    return users;
  }
}
