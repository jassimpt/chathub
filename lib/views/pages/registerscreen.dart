import 'package:chathub/controller/auth_provider.dart';
import 'package:chathub/views/pages/homescreen.dart';
import 'package:chathub/views/pages/loginscreen.dart';
import 'package:chathub/views/widgets/customtextfield.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  TextEditingController namecontroller = TextEditingController();

  TextEditingController confirmpasswordcontroller = TextEditingController();

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
            'Create New Account',
            style:
                GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Please fill in the form to continue',
            style: TextStyle(
              color: Color.fromRGBO(91, 93, 98, 1),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: CustomTextField(
                controller: namecontroller,
                hinttext: 'Name',
                fillcolor: const Color.fromRGBO(75, 58, 136, 1)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: CustomTextField(
                controller: emailcontroller,
                hinttext: 'Email',
                fillcolor: const Color.fromRGBO(75, 58, 136, 1)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: CustomTextField(
                controller: passwordcontroller,
                hinttext: 'Password',
                fillcolor: const Color.fromRGBO(75, 58, 136, 1)),
          ),
          Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: CustomTextField(
                  fillcolor: const Color.fromRGBO(75, 58, 136, 1),
                  controller: confirmpasswordcontroller,
                  hinttext: "Confirm Password")),
          const SizedBox(
            height: 130,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: GestureDetector(
              onTap: () => signup(context),
              child: Container(
                height: size.height * 0.07,
                width: size.width,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(205, 210, 232, 1),
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                    child: Text(
                  "Sign Up",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Have An Account ? ",
                style: TextStyle(color: Color.fromRGBO(103, 105, 110, 1)),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
                },
                child: const Text(
                  'Sign In',
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

  void signup(context) async {
    if (passwordcontroller.text != confirmpasswordcontroller.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Password not match')));
      return;
    }
    final authpro = Provider.of<AuthProvider>(context, listen: false);
    try {
      await authpro.signUpWithEmail(
          emailcontroller.text, passwordcontroller.text, namecontroller.text);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
