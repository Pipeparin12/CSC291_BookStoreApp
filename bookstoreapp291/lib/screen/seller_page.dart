import 'dart:developer';
import 'dart:ui';

import 'package:bookstoreapp291/model/product.dart';
import 'package:bookstoreapp291/screen/homepage.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerCentre extends StatefulWidget {
  const SellerCentre({Key? key}) : super(key: key);

  @override
  State<SellerCentre> createState() => _SellerCentreState();
}

class _SellerCentreState extends State<SellerCentre> {
  List _book = [];
  var _firestoreInstace = FirebaseFirestore.instance;

  BookBox() async {
    QuerySnapshot qn = await _firestoreInstace.collection('books').get();
    setState(() {
      inspect(qn.docs);
      for (int i = 0; i < qn.docs.length; i++) {
        _book.add({
          "bookName": qn.docs[i]["bookName"],
          "bookDes": qn.docs[i]["bookDes"],
          "bookPrice": qn.docs[i]["bookPrice"],
          "bookAmount": qn.docs[i]["bookAmount"],
          "bookImage": qn.docs[i]["bookImage"]
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    BookBox();
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
      body: SingleChildScrollView(
        child: SizedBox(
          height: 625,
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 10)),
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
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _book.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 2),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 10, left: 5, right: 5),
                        height: 50,
                        child: Container(
                          decoration: BoxDecoration(
                              color: LightColor.lightGrey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(
                                  width: 120,
                                  child: Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: Image.network(
                                      _book[index]['bookImage'][0],
                                      // fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(50),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(_book[index]['bookName'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text("Amount: " +
                                          _book[index]['bookAmount']
                                              .toString()),
                                      Text("Price: " +
                                          _book[index]['bookPrice'].toString()),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            backgroundColor:
                                                LightColor.lightGrey,
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
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.delete))
                              ]),
                        ),
                      ),
                    );
                  }),
            ))
          ]),
        ),
      ),
    );
  }
}

class BookBox extends StatefulWidget {
  const BookBox({Key? key}) : super(key: key);

  @override
  State<BookBox> createState() => _BookBoxState();
}

class _BookBoxState extends State<BookBox> {
  final Stream<QuerySnapshot> _boxstream =
      FirebaseFirestore.instance.collection('books').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          shrinkWrap: true,
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListView.builder(
                shrinkWrap: true,
                itemCount:
                    snapshot.data == null ? 0 : snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documetSnapshot =
                      snapshot.data!.docs[index];

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
                                child: Image.network(
                                  _documetSnapshot['bookImage'],
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(_documetSnapshot['bookName'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      Text("Amount: " +
                                          _documetSnapshot['bookAmount']
                                              .toString()),
                                      Text("Price: " +
                                          _documetSnapshot['bookPrice']
                                              .toString()),
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
                                          backgroundColor: LightColor.lightGrey,
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
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.delete))
                            ]),
                      ));
                });
          }).toList(),
        );
      },
    );
  }
}

class ProductBox extends StatelessWidget {
  ProductBox({Key? key, required this.product}) : super(key: key);
  final Product product;

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
                        Text("Amount: " + product.amount.toString()),
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
                            backgroundColor: LightColor.lightGrey,
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
