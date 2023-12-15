import 'package:chathub/views/pages/loginscreen.dart';
import 'package:chathub/views/pages/registerscreen.dart';
import 'package:chathub/views/widgets/components/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(23, 26, 31, 1),
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(
            height: 70,
          ),
          Text(
            'Create New Account',
            style: GoogleFonts.poppins(fontSize: 28),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Please fill in the form to continue',
            style: TextStyle(
              color: Color.fromRGBO(61, 63, 68, 1),
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child:
                CustomTextField(controller: emailcontroller, hinttext: 'Name'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child:
                CustomTextField(controller: emailcontroller, hinttext: 'Email'),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
            child: CustomTextField(
                controller: emailcontroller, hinttext: 'Password'),
          ),
          Padding(
              padding: const EdgeInsets.only(
                left: 25,
                right: 25,
              ),
              child: CustomTextField(
                  controller: passwordcontroller,
                  hinttext: "Confirm Password")),
          SizedBox(
            height: 130,
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
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
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
          SizedBox(
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
                    builder: (context) => const LoginScreen(),
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
}