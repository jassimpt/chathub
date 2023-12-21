import 'package:chathub/models/message_model.dart';
import 'package:chathub/models/user_model.dart';
import 'package:chathub/services/auth/auth_service.dart';
import 'package:chathub/views/pages/homescreen.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier {
  List<UserModel> users = [];
  List<Message> messages = [];
  AuthService service = AuthService();
  ScrollController scrollController = ScrollController();
  List<UserModel> getAllUsers() {
    service.firestore.collection('users').snapshots().listen((user) {
      users = user.docs.map((doc) => UserModel.fromJson(doc.data())).toList();
      notifyListeners();
    });
    return users;
  }

  List<Message> getMessages(String currentuserid, String recieverid) {
    List ids = [currentuserid, recieverid];
    ids.sort();
    String chatroomid = ids.join("_");
    service.firestore
        .collection("chat_room")
        .doc(chatroomid)
        .collection("messages")
        .orderBy("time", descending: false)
        .snapshots()
        .listen((message) {
      messages =
          message.docs.map((doc) => Message.fromJson(doc.data())).toList();
      notifyListeners();
      scrollDown();
    });
    return messages;
  }

  void scrollDown() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (scrollController.hasClients) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      });

  verifyOtp(String otp, context) async {
    var isverified = await service.verifyOtp(otp);

    isverified
        ? Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ))
        : ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('otp verification failer')));
    notifyListeners();
  }
}
