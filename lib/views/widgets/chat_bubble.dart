import 'package:chathub/controller/firebase_provider.dart';
import 'package:chathub/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.service,
    required this.size,
  });

  final AuthService service;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Consumer<FirebaseProvider>(
      builder: (context, value, child) {
        return ListView.builder(
          controller: value.scrollController,
          itemCount: value.messages.length,
          itemBuilder: (context, index) {
            final chats = value.messages[index];
            DateTime dateTime = chats.time!.toDate();
            String formattedTime = DateFormat.jm().format(dateTime);

            var alignment = chats.senderId == service.auth.currentUser!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft;
            var bubblecolor = chats.senderId == service.auth.currentUser!.uid
                ? const Color.fromARGB(255, 59, 43, 98)
                : Colors.white;
            var messagecolor = chats.senderId == service.auth.currentUser!.uid
                ? Colors.white
                : Colors.black;
            var borderradius = chats.senderId == service.auth.currentUser!.uid
                ? const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    topRight: Radius.circular(15))
                : const BorderRadius.only(
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15));
            print(chats.time);
            return Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
              child: Align(
                alignment: alignment,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: size.height * 0.05,
                    minWidth: size.width * 0.2,
                    maxWidth: size.width * 0.7,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 5,
                          offset: Offset(0, 5),
                        ),
                      ],
                      color: bubblecolor,
                      borderRadius: borderradius,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            chats.content!,
                            style: GoogleFonts.poppins(
                              color: messagecolor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [Text(formattedTime)],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
