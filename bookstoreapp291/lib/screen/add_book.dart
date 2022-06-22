import 'dart:async';
import 'dart:ui';

import 'package:bookstoreapp291/widget/sellerNavbar.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/screen/profile.dart';
import 'package:bookstoreapp291/screen/seller_page.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add book for sale'),
          centerTitle: true,
          backgroundColor: Colors.grey,
          leading: IconButton(
              onPressed: (() {
                Navigator.of(context).pop();
              }),
              icon: Icon(Icons.arrow_back)),
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Expanded(
                      child: SizedBox(
                    child: Column(
                      children: [
                        Expanded(child: _allEntryFieldWidget()),
                        Padding(
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.all(20.0)),
                            ),
                            onPressed: () {},
                            child: const Text('Confirm'),
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            )
          ],
        ));
  }
}

// Widget textformfield({@required hintText}) {
//   final InputDecoration textFormStyle = InputDecoration(
//     hintText: hintText,
//     border: const OutlineInputBorder(),
//     hintStyle:
//         const TextStyle(letterSpacing: 1, fontSize: 20, color: Colors.black),
//   );
//   return Material(
//     elevation: 2,
//     child: TextField(
//       enabled: true,
//       textAlign: TextAlign.center,
//       decoration: textFormStyle,
//     ),
//   );
// }

Widget _allEntryFieldWidget() {
  return Column(
    children: <Widget>[
      _entryField("Name"),
      _entryField("Description"),
      _entryField("Price"),
      _entryField("Amount"),
    ],
  );
}

Widget _entryField(String title) {
  return Container(
    margin: EdgeInsets.only(left: 30, right: 30, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}
