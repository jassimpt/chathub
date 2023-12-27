import 'package:chathub/controller/auth_provider.dart';
import 'package:chathub/controller/firebase_provider.dart';
import 'package:chathub/controller/image_provider.dart';
import 'package:chathub/services/auth/auth_gate.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyB7FQdY2oljqCiaoIsrIH70lalRgoSDt0k",
          appId: "1:668827673700:android:20808926486bc44c6f2b71",
          messagingSenderId: "668827673700",
          projectId: "chathub-37058",
          storageBucket: "chathub-37058.appspot.com"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => FirebaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ImagePickerProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: const ColorScheme.dark()),
        home: const AuthGate(),
      ),
    );
  }
}
