import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BasicProvider extends ChangeNotifier {
  File? selectedimage;
  String? otpcode;
  imageSelector({required source}) async {
    final returnedimage = await ImagePicker().pickImage(source: source);
    selectedimage = File(returnedimage!.path);
    notifyListeners();
  }

  otpSetter(value) {
    otpcode = value;
    notifyListeners();
  }
}
