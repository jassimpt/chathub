import 'package:chathub/controller/auth_provider.dart';
import 'package:chathub/views/pages/homescreen.dart';
import 'package:chathub/views/pages/phone_login_screen.dart';
import 'package:chathub/views/pages/registerscreen.dart';
import 'package:chathub/views/widgets/customtextfield.dart';
import 'package:chathub/views/widgets/squaretile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                GoogleFonts.ubuntu(fontSize: 28, fontWeight: FontWeight.bold),
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
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: CustomTextField(
                controller: emailcontroller,
                hinttext: 'Email',
                fillcolor: const Color.fromRGBO(75, 58, 136, 1)),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: CustomTextField(
                controller: passwordcontroller,
                hinttext: "Password",
                fillcolor: const Color.fromRGBO(75, 58, 136, 1),
              )),
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
                    color: const Color.fromARGB(255, 143, 157, 221),
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
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Row(
              children: [
                Expanded(
                    child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Or continue with",
                    style: GoogleFonts.ubuntu(color: Colors.grey[400]),
                  ),
                ),
                Expanded(
                    child: Divider(
                  thickness: 0.5,
                  color: Colors.grey[400],
                ))
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 25,
              right: 25,
            ),
            child: Consumer<AuthProvider>(
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SquareTile(
                      size: size,
                      image: "assets/images/google.png",
                      onTap: () {
                        value.singupWithGoogle();
                      },
                    ),
                    SquareTile(
                      size: size,
                      image: "assets/images/call.png",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PhoneLoginScreen(),
                        ));
                      },
                    ),
                    SquareTile(
                        size: size,
                        image: 'assets/images/github.png',
                        onTap: () {
                          value.signInWithGithub(context);
                        })
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 40,
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
            builder: (context) => const HomeScreen(),
          ));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
