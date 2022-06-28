import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:bookstoreapp291/routes.dart';
import 'package:bookstoreapp291/screen/profile/profile_screen.dart';
import 'package:bookstoreapp291/screen/splash/splash_screen.dart';
import 'package:bookstoreapp291/size_config.dart';
import 'package:bookstoreapp291/theme.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCP7aV-ug8cSLUCJG5CqaaMVO5oPgViu10", // Your apiKey
      appId: "1:484998251170:web:bdbf04ddf58ee78c954dfb", // Your appId
      messagingSenderId: "484998251170", // Your messagingSenderId
      projectId: "book-store-app-291", // Your projectId
    ),
  );
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
