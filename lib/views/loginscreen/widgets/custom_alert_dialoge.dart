import 'package:chathub/services/auth/auth_service.dart';
import 'package:chathub/views/homescreen/homescreen.dart';
import 'package:chathub/views/registerscreen/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class CustomAlertDialog extends StatelessWidget {
  final String veridicationId;
  CustomAlertDialog({
    required this.veridicationId,
    Key? key,
  }) : super(key: key);
  TextEditingController otpcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      backgroundColor: const Color.fromRGBO(66, 47, 129, 1),
      content: Lottie.asset(
        "assets/lottie/Animation - 1703066556723.json",
        height: 150,
      ),
      actions: [
        CustomTextField(
          controller: otpcontroller,
          hinttext: "OTP",
          fillcolor: const Color.fromRGBO(43, 40, 53, 1),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            verifyOtp(context, otpcontroller.text);
          },
          child: Container(
            height: size.height * 0.07,
            width: size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 143, 157, 221),
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

  void verifyOtp(context, String userotp) {
    AuthService service = AuthService();
    service.verifyOtp(
        verificationId: veridicationId,
        otp: userotp,
        onSuccess: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        });
  }
}
