import 'package:flutter/material.dart';
import 'components/check_out_cards.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
        "Thank you",
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
