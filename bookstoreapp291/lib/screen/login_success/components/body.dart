import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/components/default_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bookstoreapp291/sizedConfig.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight * 0.04),
        Image.asset(
          "assets/images/success.png",
          height: SizeConfig.screenHeight * 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.08),
        Text(
          "Login Success",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth * 0.6,
          child: DefaultButton(
            text: "Back to home",
            press: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return BottomNavBar();
                },
              ));
            },
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavBar())),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
