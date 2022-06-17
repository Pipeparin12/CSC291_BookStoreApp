import 'package:flutter/material.dart';
import 'package:shop_app/screens/complete_email/complete_email_screen.dart';
import 'package:shop_app/screens/complete_payment/complete_payment_screen.dart';
import 'package:shop_app/screens/complete_phone/complete_phone_screen.dart';
import 'package:shop_app/screens/complete_profile/complete_profile_screen.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/icons/User Icon.svg",
            press: () =>
                Navigator.pushNamed(context, CompleteProfileScreen.routeName),
          ),
          ProfileMenu(
            text: "Payment",
            icon: "assets/icons/Bill Icon.svg",
            press: () =>
                Navigator.pushNamed(context, CompletePaymentScreen.routeName),
          ),
          ProfileMenu(
            text: "Email",
            icon: "assets/icons/Mail.svg",
            press: () =>
                Navigator.pushNamed(context, CompleteEmailScreen.routeName),
          ),
          ProfileMenu(
            text: "Phone Number",
            icon: "assets/icons/Phone.svg",
            press: () =>
                Navigator.pushNamed(context, CompletePhoneScreen.routeName),
          ),
          ProfileMenu(
            text: "Address",
            icon: "assets/icons/Discover.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}
