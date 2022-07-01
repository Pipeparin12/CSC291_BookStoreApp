import 'package:bookstoreapp291/widget/section_title.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screen/detail_book.dart';

@override
Widget sellerCard(String sellerId) {
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('books')
          .where('sellerId', isEqualTo: sellerId)
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
                            child: Image(
                                image: NetworkImage(
                                    _documentSnapshot['bookImage']))),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(_documentSnapshot['bookName'],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                Text("Amount: " +
                                    _documentSnapshot['bookAmount'].toString()),
                                Text("Price: " +
                                    _documentSnapshot['bookPrice'].toString()),
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
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('books')
                                  .doc(_documentSnapshot['bookName'])
                                  .delete();
                            },
                            icon: Icon(Icons.delete))
                      ]),
                ));
          },
        );
      });
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
// ListTile(
//                     leading: Text(_documentSnapshot['bookName']),
//                     title: Text(
//                       "\$ ${_documentSnapshot['bookPrice']}",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.red),
//                     ),
//                     trailing: GestureDetector(
//                         child: CircleAvatar(
//                           child: Icon(Icons.remove_circle),
//                         ),
//                         onTap: () {
//                           FirebaseFirestore.instance
//                               .collection('')
//                               .doc(FirebaseAuth.instance.currentUser!.email)
//                               .collection('items')
//                               .doc(_documentSnapshot.id)
//                               .delete();
//                         }),
//                     onTap: () => Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (_) => BookDetail(
//                                   FirebaseFirestore.instance
//                                       .collection("books")
//                                       .where("bookName",
//                                           isEqualTo: _documentSnapshot["bookName"])
//                                       .snapshots(),
//                                 ))),
//                   )