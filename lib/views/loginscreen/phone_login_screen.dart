import 'package:chathub/services/auth/auth_service.dart';
import 'package:chathub/views/loginscreen/widgets/custom_phone_field.dart';
import 'package:chathub/views/registerscreen/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';

class PhoneLoginScreen extends StatelessWidget {
  PhoneLoginScreen({super.key});

  final TextEditingController phonecontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController otpcontroller = TextEditingController();
  final AuthService service = AuthService();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromRGBO(53, 32, 111, 1),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollUpdateNotification) {
              final bottomInset = MediaQuery.of(context).viewInsets.bottom;
              if (bottomInset > 0) {
                Scrollable.ensureVisible(
                  notification.context!,
                  alignmentPolicy:
                      ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
                );
              }
            }
            return true;
          },
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              children: [
                Lottie.asset(
                  "assets/lottie/Animation - 1703063475434.json",
                  height: 300,
                  width: 300,
                ),
                Center(
                  child: Text(
                    "OTP Verification",
                    style: GoogleFonts.ubuntu(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'We will send you a ',
                      style: GoogleFonts.montserrat(fontSize: 16),
                    ),
                    Text(
                      "One Time Password",
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Text("on your mobile number"),
                const SizedBox(height: 50),
                Column(
                  children: [
                    CustomPhoneField(
                        controller: phonecontroller, hinttext: "Phone"),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: CustomTextField(
                          controller: namecontroller,
                          hinttext: "Name",
                          fillcolor: const Color.fromRGBO(75, 58, 136, 1)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: CustomTextField(
                          controller: emailcontroller,
                          hinttext: "Email",
                          fillcolor: const Color.fromRGBO(75, 58, 136, 1)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: InkWell(
                        splashColor: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                        onTap: () {
                          String countrycode = "+91";
                          String phonenumber =
                              countrycode + phonecontroller.text;
                          service.signInwithPhone(phonenumber, context,
                              namecontroller.text, emailcontroller.text);
                        },
                        child: Container(
                          width: size.width,
                          height: size.height * 0.08,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 143, 157, 221)
                                  .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(25)),
                          child: Center(
                              child: Text(
                            'Generate Otp',
                            style: GoogleFonts.ubuntu(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
