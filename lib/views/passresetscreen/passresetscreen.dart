import 'package:chathub/services/auth/auth_service.dart';
import 'package:chathub/views/registerscreen/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class PassReset extends StatelessWidget {
  PassReset({super.key});
  final TextEditingController emailcontroller = TextEditingController();
  final AuthService service = AuthService();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(53, 32, 111, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.02,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  SizedBox(
                    width: size.width * 0.1,
                  ),
                  Text(
                    'Forgot Password',
                    style: GoogleFonts.poppins(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Center(
                child: LottieBuilder.asset(
                  'assets/lottie/Animation - 1704185814428.json',
                  height: 300,
                ),
              ),
              Text(
                'Please enter your Emailaddress to',
                style: GoogleFonts.poppins(
                    fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Text('to recieve a reset link',
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.amber)),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CustomTextField(
                    controller: emailcontroller,
                    hinttext: 'enter your email',
                    fillcolor: const Color.fromRGBO(75, 58, 136, 1)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: GestureDetector(
                  onTap: () {
                    service.passwordReset(
                        email: emailcontroller.text.trim(), context: context);
                  },
                  child: Container(
                    height: size.height * 0.07,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                        child: Text(
                      "Send reset link",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
