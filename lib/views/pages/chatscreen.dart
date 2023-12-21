import 'package:chathub/controller/firebase_provider.dart';
import 'package:chathub/models/user_model.dart';
import 'package:chathub/services/auth/auth_service.dart';
import 'package:chathub/services/chat/chat_service.dart';
import 'package:chathub/views/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key, required this.user});
  UserModel user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messagecontroller = TextEditingController();
  AuthService service = AuthService();
  @override
  void initState() {
    super.initState();
    final currentuserid = service.auth.currentUser!.uid;

    Provider.of<FirebaseProvider>(context, listen: false)
        .getMessages(currentuserid, widget.user.uid!);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(41, 15, 102, 1),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: size.width * .28,
                  ),
                  Text(
                    widget.user.name!,
                    style: GoogleFonts.poppins(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    // messages container
                    width: size.width,
                    decoration: const BoxDecoration(
                        color: Color.fromRGBO(239, 237, 247, 1),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(50))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: ChatBubble(service: service, size: size),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 5,
                    right: 5,
                    child: Container(
                      // chating field
                      width: size.width * 0.9,
                      height: size.height * 0.08,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                style: GoogleFonts.poppins(
                                    color: Colors.black, fontSize: 18),
                                controller: messagecontroller,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    filled: true,
                                    fillColor:
                                        const Color.fromRGBO(239, 237, 247, 1)),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                sendMessage();
                              },
                              icon: const Icon(
                                Icons.send_rounded,
                                color: Colors.amber,
                                size: 30,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  sendMessage() async {
    if (messagecontroller.text.isNotEmpty) {
      await ChatService().sendMessage(widget.user.uid!, messagecontroller.text);
      messagecontroller.clear();
    }
  }
}
