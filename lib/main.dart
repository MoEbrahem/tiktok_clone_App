import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_flutter/View/screens/auth/loginScreen.dart';
import 'package:tiktok_flutter/constants.dart';
import 'package:tiktok_flutter/controllers/authController.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
            apiKey: "AIzaSyB7ye4XimbWezzsICfXFRfxMSlGsOq1Dvg",
            appId: "com.example.tiktok_flutter",
            messagingSenderId: "973304430451",
            projectId: "tiktok-ec56e",
          ),
        ).then((value) {
          Get.put(AuthController());
        })
      : await Firebase.initializeApp().then((value) {
          Get.put(AuthController());
        });
      await FirebaseAppCheck.instance
      // Your personal reCaptcha public key goes here:
      .activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.debug,
      ); 
  runApp(const MyApp());
}  

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tiktok',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: LoginScreen(),
    );
  }
}
