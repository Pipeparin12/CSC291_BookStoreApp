import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookDetail extends StatefulWidget {
  var _book;
  BookDetail(this._book);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  late int counter = 1;
  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      if (counter == 0) {
        return null;
      } else {
        counter--;
      }
    });
  }

  Future addToCart() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-cart-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc(widget._book["bookName"])
        .set({
      "name": widget._book["bookName"],
      "price": widget._book["bookPrice"],
      "images": widget._book["bookImage"],
      "des": widget._book["bookDes"],
      "amount": widget._book["bookAmount"],
      "itemInCart": counter
    }).then((value) => print("Added to cart"));
  }

  Future addToBookmark() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users-bookmark-items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget._book["bookName"],
      "price": widget._book["bookPrice"],
      "images": widget._book["bookImage"],
      "des": widget._book["bookDes"],
      "amount": widget._book["bookAmount"]
    }).then((value) => print("Added to favourite"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Detail Book'),
        centerTitle: true,
        actions: [
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users-favourite-items")
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection('books')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Text("No data");
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    backgroundColor: LightColor.darkgrey,
                    child: IconButton(
                      onPressed: () => snapshot.data.docs.length == 0
                          ? addToBookmark()
                          : print("Already Added"),
                      icon: snapshot.data.docs.length == 0
                          ? Icon(
                              Icons.bookmark_border,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.bookmark,
                              color: Colors.red,
                            ),
                    ),
                  ),
                );
              })
        ],
      ),
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .6,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget._book['bookImage']),
                  fit: BoxFit.contain)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: LightColor.lightGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget._book['bookName'],
                          style: GoogleFonts.ptSans(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: LightColor.black),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    children: [
                      Text(
                        widget._book['bookPrice'].toString() + " Bath",
                        style: GoogleFonts.ptSans(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(widget._book['bookDes']),
                  ),
                ),
                Padding(padding: EdgeInsets.all(20)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Container(
                            height: 49,
                            width: 49,
                            decoration: BoxDecoration(
                                color: LightColor.skyBlue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: TextButton(
                              child: Text(
                                '-',
                                style: GoogleFonts.ptSans(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                decrement();
                              },
                            )),
                          ),
                          Container(
                            height: 49,
                            width: 70,
                            child: Center(
                                child: Text(
                              '$counter',
                              style: GoogleFonts.ptSans(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ),
                          Container(
                            height: 49,
                            width: 49,
                            decoration: BoxDecoration(
                                color: LightColor.skyBlue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: TextButton(
                              child: Text(
                                '+',
                                style: GoogleFonts.ptSans(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                increment();
                              },
                            )),
                          ),
                        ],
                      )),
                      GestureDetector(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          decoration: BoxDecoration(
                              color: LightColor.iconColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text('Add to cart'),
                        ),
                        onTap: () => addToCart(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

