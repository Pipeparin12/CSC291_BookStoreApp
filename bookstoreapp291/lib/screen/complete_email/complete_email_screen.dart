import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteEmailScreen extends StatelessWidget {
  static String routeName = "/complete_email";
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
