import 'package:bookstoreapp291/screen/add_book.dart';
import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/widget/sellerNavbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/screen/homepage.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';

void main() async {
  runApp(const MyApp());
  DioInstance.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SignInScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
