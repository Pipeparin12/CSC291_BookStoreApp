import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/screen/sign_up/sign_up_screen.dart';

import '../constants.dart';
import '../sizedConfig.dart';

class HaveAccountText extends StatelessWidget {
  const HaveAccountText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have account ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignInScreen())),
          child: Text(
            "Sign In",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
