import 'dart:ui';

import 'package:bookstoreapp291/screen/add_book.dart';
import 'package:bookstoreapp291/screen/profile.dart';
import 'package:bookstoreapp291/widget/sellerNavbar.dart';
import 'package:flutter/material.dart';

class SellerCentre extends StatefulWidget {
  const SellerCentre({Key? key}) : super(key: key);

  @override
  State<SellerCentre> createState() => _SellerCentreState();
}

class _SellerCentreState extends State<SellerCentre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller Centre'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: Icon(Icons.add_shopping_cart),
      ),
      body: Column(children: <Widget>[
        Padding(padding: EdgeInsets.all(10)),
        Text('Your sell book list'),
        ProductBox(name: 'Book1', amount: '1', price: 400, image: ''),
        ProductBox(name: 'Book1', amount: '1', price: 400, image: ''),
      ]),
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox(
      {Key? key,
      required this.name,
      required this.amount,
      required this.price,
      required this.image})
      : super(key: key);
  final String name;
  final String amount;
  final int price;
  final String image;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 20, left: 20),
        height: 120,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Image.asset("assets/appimages/" + image),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(this.name,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("Amount: " + this.amount),
                          Text("Price: " + this.price.toString()),
                        ],
                      )))
            ])));
  }
}
