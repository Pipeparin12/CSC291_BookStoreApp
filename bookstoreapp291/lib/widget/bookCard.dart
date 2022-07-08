import 'dart:developer';

import 'package:bookstoreapp291/widget/section_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/theme/light_color.dart';

import '../screen/detail_book.dart';

class bookCard extends StatefulWidget {
  const bookCard({Key? key}) : super(key: key);

  @override
  State<bookCard> createState() => _bookCardState();
}

class _bookCardState extends State<bookCard> {
  getData() async {
    
  }
  @override
  Widget build(BuildContext context) {
    return Container(
    padding: EdgeInsets.only(right: 20, left: 20, bottom: 10),
    height: 120,
    child: Container(
      decoration: BoxDecoration(
          color: LightColor.lightGrey, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5.0),
            // child: Image(image: NetworkImage('')),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("Price: " + ''),
                ],
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.delete))
        ],
      ),
    ),
  );
  }
}

