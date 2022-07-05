import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:math';

import 'package:bookstoreapp291/model/book.dart';
import 'package:bookstoreapp291/sizedConfig.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/widget/sellerCard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as path;

class AddBook extends StatefulWidget {
  AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  late String bookName;
  late String bookDes;
  late int bookPrice;
  late int bookAmount;
  String? imageUrl;
  File? imageFile;
  final scrollController = ScrollController();
  final imagePicker = ImagePicker();

  getBookName(String name) {
    bookName = name;
  }

  getBookDes(String des) {
    bookDes = des;
  }

  getPrice(int price) {
    bookPrice = price;
  }

  getAmount(int amount) {
    bookAmount = amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AddBook Page'),
      ),
    );
  }

  Widget _entryField(
      String title, String hintText, Function(String) onChanged) {
    return Container(
      margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              obscureText: false,
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Please enter the $title';
                }
                return null;
              },
              onChanged: onChanged,
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
}
