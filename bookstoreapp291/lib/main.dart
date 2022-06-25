import 'package:flutter/material.dart';
import 'package:shop_app/routes.dart';
import 'package:shop_app/screen/profile/profile_screen.dart';
import 'package:shop_app/screen/splash/splash_screen.dart';
import 'package:shop_app/size_config.dart';
import 'package:shop_app/theme.dart';

void main() {
  runApp(MyApp());
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
