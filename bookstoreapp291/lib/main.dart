import 'package:bookstoreapp291/screen/add_book.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/screen/seller_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AddBook(),
    );
  }
}
