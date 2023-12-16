import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key, required this.controller, required this.hinttext});

  final TextEditingController controller;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromRGBO(75, 58, 136, 1),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(20)),
          hintText: hinttext,
          hintStyle: TextStyle()),
    );
  }
}
