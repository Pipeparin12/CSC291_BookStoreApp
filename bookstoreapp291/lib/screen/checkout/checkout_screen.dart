import 'package:flutter/material.dart';
import 'package:bookstoreapp291/model/Cart.dart';

import 'components/body.dart';
import 'components/check_out_cards.dart';

class CheckoutScreen extends StatelessWidget {
  static String routeName = "/checkout";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Column(
        children: [
          Text(
            "Your Bill",
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    ),
      body: CheckoutsCard(),
    );
  }
}
