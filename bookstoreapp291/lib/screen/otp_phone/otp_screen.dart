import 'package:flutter/material.dart';
import 'package:bookstoreapp291/sizedConfig.dart';

import 'components/body.dart';

class OtpPhoneScreen extends StatelessWidget {
  static String routeName = "/otp MobliePhone";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("OTP Verification"),
      ),
      body: Body(),
    );
  }
}
