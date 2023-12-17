import 'package:chathub/controller/firebase_provider.dart';
import 'package:chathub/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<FirebaseProvider>(context, listen: false).getAllUsers();
    super.initState();
  }

  AuthService service = AuthService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(41, 15, 102, 1),
      body: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Messages',
                    style: GoogleFonts.ubuntu(
                        fontSize: 23, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        service.signOut();
                      },
                      icon: const Icon(Iconsax.logout))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  filled: true,
                  fillColor: const Color.fromRGBO(102, 106, 179, 1),
                  hintText: 'Search ',
                  prefixIcon: const Icon(Iconsax.search_normal)),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))),
              child: Consumer<FirebaseProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.users.length,
                    itemBuilder: (context, index) {
                      final userdetails = value.users[index];
                      print(userdetails.name);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage(
                              'assets/images/user.jpg',
                            ),
                          ),
                          title: Text(
                            userdetails.name!,
                            style: TextStyle(color: Colors.black),
                          ),
                          subtitle: Text(
                            'hello',
                            style: TextStyle(color: Colors.black),
                          ),
                          trailing: Text(
                            'Friday',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.4)),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
