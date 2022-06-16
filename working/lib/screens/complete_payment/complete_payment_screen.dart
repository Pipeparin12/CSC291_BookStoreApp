import 'package:flutter/material.dart';

import 'components/body.dart';

class CompletePaymentScreen extends StatelessWidget {
  static String routeName = "/complete_Payment";
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
