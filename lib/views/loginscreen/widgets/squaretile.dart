import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  SquareTile(
      {super.key,
      required this.size,
      required this.image,
      required this.onTap});

  final Size size;
  final String image;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: const Color.fromRGBO(78, 55, 155, 1),
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        height: size.height * .1,
        width: size.width * .2,
        decoration: BoxDecoration(
            border: Border.all(color: const Color.fromRGBO(164, 148, 231, 1)),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Image.asset(
          image,
          color: const Color.fromRGBO(164, 148, 231, 1),
          height: 35,
          width: 35,
        )),
      ),
    );
  }
}
