import 'dart:developer';

import 'package:bookstoreapp291/widget/section_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screen/detail_book.dart';

@override
Widget bookCard(String collectionName) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection(collectionName)
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('items')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
          itemBuilder: (_, index) {
            DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];

            return GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BookDetail({
                            "bookName": _documentSnapshot["name"],
                            "bookDes": _documentSnapshot["des"],
                            "bookPrice": _documentSnapshot["price"],
                            "bookAmount": _documentSnapshot["amount"],
                            "bookImage": _documentSnapshot["images"]
                          }))),
              child: Container(
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
                              child: Image(
                                  image: NetworkImage(
                                      _documentSnapshot['images']))),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(_documentSnapshot['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("Price: " +
                                      _documentSnapshot['price'].toString()),
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection(collectionName)
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection('items')
                                    .doc(_documentSnapshot.id)
                                    .delete();
                              },
                              icon: Icon(Icons.delete))
                        ]),
                  )),
            );
          },
        );
      });
}
