import 'package:bookstoreapp291/AddProfile.dart';
import 'package:bookstoreapp291/screen/profile/components/profile_detail.dart';
import 'package:bookstoreapp291/screen/profile/profile_screen.dart';
import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'profile_detail.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            FlutterLogo(
              size: 100,
            ),
            SizedBox(height: 20),
            ProfileMenu(
              text: "Edit Profile",
              icon: "assets/icons/User.svg",
              press: () {},
            ),
            ProfileMenu(
              text: "Sign Out",
              icon: "assets/icons/Log out.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}
