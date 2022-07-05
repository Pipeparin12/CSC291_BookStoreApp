import 'dart:developer';
import 'dart:ui';

import 'package:bookstoreapp291/screen/homepage.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:bookstoreapp291/widget/sellerCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerCentre extends StatefulWidget {
  const SellerCentre({Key? key}) : super(key: key);

  @override
  State<SellerCentre> createState() => _SellerCentreState();
}

class _SellerCentreState extends State<SellerCentre> {
  var _firestoreInstace = FirebaseFirestore.instance;
  String sellerMail = FirebaseAuth.instance.currentUser!.email.toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Centre'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BottomNavBar();
            }));
          },
          icon: Icon(Icons.add_shopping_cart),
        ),
      ),
      body: SizedBox(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 15.0),
              child: const Text(
                'Your sell book list',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SafeArea(
              child: SizedBox(
                child: sellerCard(sellerMail),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
