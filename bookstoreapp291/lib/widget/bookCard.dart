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

class bookCard extends StatefulWidget {
  const bookCard({Key? key}) : super(key: key);

  @override
  State<bookCard> createState() => _bookCardState();
}

class _bookCardState extends State<bookCard> {
  final Stream<QuerySnapshot> _bookStream = FirebaseFirestore.instance
      .collection('books')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('books')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _bookStream,
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
              itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];

                return Card(
                    elevation: 5,
                    child: ListTile(
                      leading: Text(_documentSnapshot['name']),
                      title: Text(
                        "\$ ${_documentSnapshot['price']}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ));
              },
            );
          }).toList(),
        );
      },
    );
  }
}
