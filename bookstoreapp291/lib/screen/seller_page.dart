import 'dart:ui';

import 'package:bookstoreapp291/model/product.dart';
import 'package:bookstoreapp291/screen/homepage.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/theme/light_color.dart';

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
            icon: Icon(Icons.add_shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BottomNavBar();
              }));
            }),
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
          ...List.generate(demoProducts.length,
              (index) => ProductBox(product: demoProducts[index], amount: 1))
        ]),
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({Key? key, required this.product, required this.amount})
      : super(key: key);
  final Product product;
  final int amount;

  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 10),
        height: 120,
        child: Container(
          decoration: BoxDecoration(
              color: LightColor.lightGrey,
              borderRadius: BorderRadius.circular(10)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Image.asset(
                    product.images,
                    fit: BoxFit.contain,
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(product.name,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text("Amount: " + this.amount.toString()),
                        Text("Price: " + product.price.toString()),
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
              ]),
        ));
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
