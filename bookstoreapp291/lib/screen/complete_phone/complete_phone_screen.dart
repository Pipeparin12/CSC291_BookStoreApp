import 'package:flutter/material.dart';

import 'components/body.dart';

class CompletePhoneScreen extends StatelessWidget {
  static String routeName = "/complete_phone";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill the info'),
      ),
      body: Body(),
    );
  }
}
