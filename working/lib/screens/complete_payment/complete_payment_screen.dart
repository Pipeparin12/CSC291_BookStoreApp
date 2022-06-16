mport 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = "/complete_Address";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fill up'),
      ),
      body: Body(),
    );
  }
}