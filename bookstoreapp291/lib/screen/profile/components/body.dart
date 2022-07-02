import 'dart:ffi';

import 'package:bookstoreapp291/screen/profile/profile_screen.dart';
import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/screen/complete_address/complete_address_screen.dart';
import 'package:bookstoreapp291/screen/complete_email/complete_email_screen.dart';
import 'package:bookstoreapp291/screen/complete_payment/complete_payment_screen.dart';
import 'package:bookstoreapp291/screen/complete_phone/complete_phone_screen.dart';
import 'package:bookstoreapp291/screen/complete_profile/complete_profile_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String login = '';
  Widget showLogin() {
    return Text('Name: $login');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          showLogin(),
          ProfilePic(title: ''),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompleteProfileScreen())),
          ),
          ProfileMenu(
            text: "Payment",
            icon: "assets/icons/Bill Icon.svg",
            press: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompletePaymentScreen())),
          ),
          ProfileMenu(
            text: "Email",
            icon: "assets/icons/Mail.svg",
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CompleteEmailScreen())),
          ),
          ProfileMenu(
            text: "Phone Number",
            icon: "assets/icons/Phone.svg",
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => CompletePhoneScreen())),
          ),
          ProfileMenu(
            text: "Address",
            icon: "assets/icons/Discover.svg",
            press: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CompleteAddressScreen())),
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
