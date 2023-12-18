import 'package:chathub/controller/auth_provider.dart';
import 'package:chathub/views/pages/homescreen.dart';

import 'package:chathub/views/pages/registerscreen.dart';
import 'package:chathub/views/widgets/components/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(53, 32, 111, 1),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Text(
            'Welcome Back!',
            style:
                GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Please sign in to your account',
            style: TextStyle(
              color: Color.fromRGBO(91, 93, 98, 1),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child:
                CustomTextField(controller: emailcontroller, hinttext: 'Email'),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: CustomTextField(
                  controller: passwordcontroller, hinttext: "Password")),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
            child: GestureDetector(
              onTap: () {
                signIn(context);
              },
              child: Container(
                height: size.height * 0.07,
                width: size.width,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(205, 210, 232, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                    child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Forgot password ?',
                  style: TextStyle(
                    color: Color.fromRGBO(91, 93, 98, 1),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Container(
              height: size.height * 0.07,
              width: size.width,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/search.png',
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Sign In With Google",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't Have An Account ? ",
                style: TextStyle(color: Color.fromRGBO(103, 105, 110, 1)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ));
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      )),
    );
  }

  void signIn(context) {
    final signinservices = Provider.of<AuthProvider>(context, listen: false);
    try {
      signinservices.signInWithEmail(
          emailcontroller.text, passwordcontroller.text);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
