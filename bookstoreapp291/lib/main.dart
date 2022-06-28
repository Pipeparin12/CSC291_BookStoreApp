import 'package:bookstoreapp291/screen/add_book.dart';
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
          apiKey: 'AIzaSyCP7aV-ug8cSLUCJG5CqaaMVO5oPgViu10',
          appId: '1:484998251170:web:bdbf04ddf58ee78c954dfb',
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
      home: SignInScreen(),
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrong!'),
              );
            } else if (snapshot.hasData) {
              return BottomNavBar();
            } else {
              return SignForm();
            }
          },
        ),
      );
}
