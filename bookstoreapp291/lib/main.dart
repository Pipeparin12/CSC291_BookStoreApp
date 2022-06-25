import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/routes.dart';
import 'package:bookstoreapp291/screen/profile/profile_screen.dart';
import 'package:bookstoreapp291/screen/splash/splash_screen.dart';
import 'package:bookstoreapp291/size_config.dart';
import 'package:bookstoreapp291/theme.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInScreen(),
    );
  }
}
