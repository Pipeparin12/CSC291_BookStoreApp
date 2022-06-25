import 'package:flutter/material.dart';

import 'components/body.dart';

class CompleteAddressScreen extends StatelessWidget {
  static String routeName = "/complete_Address";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Body(),
    );
  }
}
