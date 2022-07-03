import 'package:bookstoreapp291/AddProfile.dart';
import 'package:bookstoreapp291/screen/profile/components/profile_detail.dart';
import 'package:bookstoreapp291/screen/profile/profile_screen.dart';
import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/screen/complete_address/complete_address_screen.dart';
import 'package:bookstoreapp291/screen/complete_email/complete_email_screen.dart';

import 'package:bookstoreapp291/screen/complete_payment/complete_payment_screen.dart';
import 'package:bookstoreapp291/screen/complete_phone/complete_phone_screen.dart';
import 'package:bookstoreapp291/screen/complete_profile/complete_profile_screen.dart';

import 'profile_detail.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(title: ''),
          SizedBox(height: 20),
          ProfileDetail(this),
          ProfileMenu(
            text: "Edit Profile",
            icon: "assets/icons/User.svg",
            press: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddProfile())),
          ),
          ProfileMenu(
            text: "Sign Out",
            icon: "assets/icons/Log out.svg",
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen())),
          ),
        ],
      ),
    );
  }
}
