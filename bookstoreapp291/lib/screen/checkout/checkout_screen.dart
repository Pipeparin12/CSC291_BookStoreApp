import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/model/Cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/body.dart';
import 'components/check_out_cards.dart';

var inCart = FirebaseFirestore.instance
    .collection('users-cart-items')
    .doc(FirebaseAuth.instance.currentUser!.email)
    .collection('items')
    .doc('itemInCart');

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
