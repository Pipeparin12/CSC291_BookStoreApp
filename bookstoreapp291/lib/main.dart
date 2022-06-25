import 'package:flutter/material.dart';
import 'package:bookstoreapp291/screen/homepage.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavBar(),
    );
  }
}