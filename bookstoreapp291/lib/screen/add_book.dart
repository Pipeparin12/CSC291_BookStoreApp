import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

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
                        Expanded(
                          child: _allEntryFieldWidget(),
                        ),
                        Container(
                          child: Expanded(
                              child: IconButton(
                                  onPressed: () {},
                                  iconSize: 120,
                                  icon: Icon(Icons.add_a_photo_outlined))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey),
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

Widget _allEntryFieldWidget() {
  return Column(
    children: <Widget>[
      _entryField("Name", "Enter Book name"),
      _entryField("Description", "Enter Description"),
      _entryField("Price", "Enter Price"),
      _entryField("Amount", "Enter Price"),
    ],
  );
}

Widget _entryField(String title, String hintText) {
  return Container(
    margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              labelText: title,
              hintText: hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        )
      ],
    ),
  );
}
