import 'package:bookstoreapp291/screen/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/screen/complete_address/complete_address_screen.dart';
import 'package:bookstoreapp291/screen/complete_email/complete_email_screen.dart';
import 'package:bookstoreapp291/screen/complete_payment/complete_payment_screen.dart';
import 'package:bookstoreapp291/screen/complete_phone/complete_phone_screen.dart';
import 'package:bookstoreapp291/screen/complete_profile/complete_profile_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfileScreen(),
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
        ],
      ),
    );
  }
}
