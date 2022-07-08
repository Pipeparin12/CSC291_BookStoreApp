import 'package:bookstoreapp291/widget/section_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/theme/light_color.dart';

import '../screen/detail_book.dart';

TextEditingController bookNameController = TextEditingController();
TextEditingController bookDesController = TextEditingController();
TextEditingController bookPriceController = TextEditingController();
TextEditingController bookAmountController = TextEditingController();
late String bookId;

@override
Widget sellerCard() {
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
                  child: Image(image: NetworkImage(''))),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text('', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Amount: " + ''),
                    ],
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  AlertDialog(
                    backgroundColor: LightColor.lightGrey,
                    scrollable: true,
                    title: Text('Edit'),
                    content: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            _entryField("Name", bookNameController),
                            _entryField("Description", bookDesController),
                            _entryField("Price", bookPriceController),
                            _entryField("Amount", bookAmountController),
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
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.delete))
            ]),
      ));
}

Widget _entryField(String title, TextEditingController controller) {
  return Container(
    margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(2.0),
          child: TextFormField(
            controller: controller,
            autofocus: false,
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
