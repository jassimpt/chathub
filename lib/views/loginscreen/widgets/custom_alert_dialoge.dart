import 'package:chathub/controller/basicprovider.dart';
import 'package:chathub/services/auth/auth_service.dart';
import 'package:chathub/views/homescreen/homescreen.dart';
import 'package:chathub/views/registerscreen/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class CustomAlertDialog extends StatelessWidget {
  final String veridicationId;
  CustomAlertDialog({
    required this.veridicationId,
    super.key,
  });
  final TextEditingController otpcontroller = TextEditingController();
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
        // CustomTextField(
        //   controller: otpcontroller,
        //   hinttext: "OTP",
        //   fillcolor: const Color.fromRGBO(43, 40, 53, 1),
        // ),
        Pinput(
          length: 6,
          showCursor: true,
          defaultPinTheme: PinTheme(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.amber)),
          ),
          onChanged: (value) {
            Provider.of<BasicProvider>(context, listen: false).otpSetter(value);
          },
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            String userotp =
                Provider.of<BasicProvider>(context, listen: false).otpcode ??
                    "";
            verifyOtp(context, userotp);
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
                builder: (context) => const HomeScreen(),
              ));
        });
  }
}
