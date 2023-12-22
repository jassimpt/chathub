import 'package:chathub/controller/firebase_provider.dart';
import 'package:chathub/views/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class CustomAlertDialog extends StatelessWidget {
  final TextEditingController otpController;

  const CustomAlertDialog({Key? key, required this.otpController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return AlertDialog(
      backgroundColor: Color.fromRGBO(66, 47, 129, 1),
      content: Lottie.asset(
        "assets/lottie/Animation - 1703066556723.json",
        height: 150,
      ),
      actions: [
        CustomTextField(
          controller: otpController,
          hinttext: "OTP",
          fillcolor: Color.fromRGBO(43, 40, 53, 1),
        ),
        SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Provider.of<FirebaseProvider>(context, listen: false)
                .verifyOtp(otpController.text, context);
          },
          child: Container(
            height: size.height * 0.07,
            width: size.width,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 143, 157, 221),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                'Submit',
                style: GoogleFonts.ubuntu(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
