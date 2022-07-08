import 'package:bookstoreapp291/screen/profile/components/addProfile.dart';
import 'package:bookstoreapp291/screen/profile/components/profile_detail.dart';
import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import 'profile_detail.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(title: 'Isas nine'),
          SizedBox(height: 20),
          ProfileDetail(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Edit Profile",
            icon: "assets/icons/User.svg",
            press: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProfile())),
          ),
          ProfileMenu(
            text: "Sign Out ",
            icon: "assets/icons/Log out.svg",
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen())),
          ),
        ],
      ),
    );
  }
}
