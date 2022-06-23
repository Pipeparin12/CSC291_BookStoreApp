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
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.add_shopping_cart),
        ),
      ),
      body: SingleChildScrollView(
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
          ProductBox(
              name: 'Book1',
              amount: '1',
              price: 400,
              image: 'images/arleneFink.jpg'),
          ProductBox(
              name: 'Book1',
              amount: '1',
              price: 400,
              image: 'images/blueBook.jpg'),
          ProductBox(
              name: 'Book1',
              amount: '1',
              price: 400,
              image: 'images/arleneFink.jpg'),
          ProductBox(
              name: 'Book1',
              amount: '1',
              price: 400,
              image: 'images/arleneFink.jpg'),
          ProductBox(
              name: 'Book1',
              amount: '1',
              price: 400,
              image: 'images/arleneFink.jpg'),
          ProductBox(
              name: 'Book1',
              amount: '1',
              price: 400,
              image: 'images/arleneFink.jpg'),
          ProductBox(
              name: 'Book1',
              amount: '1',
              price: 400,
              image: 'images/arleneFink.jpg'),
          ProductBox(
              name: 'Book1',
              amount: '1',
              price: 400,
              image: 'images/arleneFink.jpg'),
          ProductBox(
              name: 'Book1',
              amount: '1',
              price: 400,
              image: 'images/arleneFink.jpg'),
        ]),
      ),
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
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
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Text('Edit'),
                          content: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Form(
                              child: Column(
                                children: <Widget>[
                                  _entryField(
                                    "Name",
                                  ),
                                  _entryField(
                                    "Description",
                                  ),
                                  _entryField(
                                    "Price",
                                  ),
                                  _entryField("Amount"),
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text('Save'),
                              ),
                            )
                          ],
                        );
                      });
                },
                icon: Icon(Icons.create_rounded),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete))
            ])));
  }
}

Widget _entryField(String title) {
  return Container(
    margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(2.0),
          child: TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              labelText: title,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        )
      ],
    ),
  );
}
