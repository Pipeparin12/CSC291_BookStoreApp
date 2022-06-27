import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bookstoreapp291/routes.dart';
import 'package:bookstoreapp291/screen/profile/profile_screen.dart';
import 'package:bookstoreapp291/screen/splash/splash_screen.dart';
import 'package:bookstoreapp291/size_config.dart';
import 'package:bookstoreapp291/theme.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
