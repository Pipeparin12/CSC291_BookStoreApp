import 'package:flutter/material.dart';

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
            press: () => {},
          ),
          ProfileMenu(
            text: "Payment",
            icon: "assets/icons/Bill Icon.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Email",
            icon: "assets/icons/Mail.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Phone Number",
            icon: "assets/icons/Phone.svg",
            press: () {},
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
