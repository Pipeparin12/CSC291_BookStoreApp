import 'package:bookstoreapp291/screen/add_book.dart';
import 'package:bookstoreapp291/screen/login_success/login_success_screen.dart';
import 'package:bookstoreapp291/screen/sign_in/components/sign_form.dart';
import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:bookstoreapp291/screen/sign_up/sign_up_screen.dart';
import 'package:bookstoreapp291/test.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/widget/sellerNavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/screen/homepage.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: 'AIzaSyAoZA5MxzzcTlMObKvN6omJeLHsLJfo1GM',
          appId: '1:484998251170:android:f0db595777a80f35954dfb',
          messagingSenderId: '484998251170',
          projectId: 'book-store-app-291'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: SignInScreen(),
    );
  }
}
