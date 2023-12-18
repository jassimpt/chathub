import 'package:chathub/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  sendMessage(String recieverId, String message) async {
    final String currentUserId = firebaseAuth.currentUser!.uid;
    final String currentuseremail = firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    Message newmessage = Message(
        content: message,
        recieverId: recieverId,
        senderId: currentUserId,
        time: timestamp,
        senderemail: currentuseremail);

    List ids = [currentUserId, recieverId];
    ids.sort();
    String chatroomid = ids.join("_");
    await firestore
        .collection("chat_room")
        .doc(chatroomid)
        .collection("messages")
        .add(newmessage.toJson());
  }
}
