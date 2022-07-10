import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:math';

import 'package:bookstoreapp291/model/book.dart';
import 'package:bookstoreapp291/service/api/book.dart';
import 'package:bookstoreapp291/sizedConfig.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/widget/sellerCard.dart';
import 'package:bookstoreapp291/widget/sellerNavbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as path;

class EditBook extends StatefulWidget {
  String? id;
  EditBook({Key? key, this.id}) : super(key: key);

  @override
  State<EditBook> createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  final _formKey = GlobalKey<FormState>();
  var book;
  late String bookName;
  late String bookDes;
  late int bookAmount;
  late String imageUrl;
  final scrollController = ScrollController();
  final bookNameController = TextEditingController();
  final bookDesController = TextEditingController();
  final amountController = TextEditingController();

  Future<void> getBook() async {
    try {
      print(widget.id);
      var result = await BookApi.getBook(widget.id!);
      setState(() {
        book = Map<String, dynamic>.from(result.data['book']);
        print(book);
        print(book['bookName']);
      });
      print(widget.id);

      if (result.data["success"]) {
        Book newBook = Book.fromJson(result.data["book"]);
        setState(() {
          setState(() {
            bookNameController.text = newBook.bookName;
            bookDesController.text = newBook.bookDescription;
          });
        });
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<void> UpdateBook() async {
    try {
      print(widget.id);
      var result =
          await BookApi.updateBook(widget.id!, bookName, bookDes, bookAmount);
      setState(() {
        print('Update successfully');
      });
    } on DioError catch (e) {
      print(e);
    }
  }

  getBookName(String name) {
    bookName = name;
  }

  getBookDes(String des) {
    bookDes = des;
  }

  getAmount(int amount) {
    bookAmount = amount;
  }

  getUrl(String url) {
    imageUrl = url;
  }

  @override
  void initState() {
    super.initState();
    getBook();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Edit Book Detail'),
          centerTitle: true,
          backgroundColor: Colors.grey,
        ),
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            controller: scrollController,
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
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 30),
                              child: Column(
                                children: [
                                  _entryField('Name', 'Enter Book Name',
                                      (String name) {
                                    getBookName(name);
                                  }, bookNameController),
                                  _entryField(
                                      'Description', 'Enter Description',
                                      (String des) {
                                    getBookDes(des);
                                  }, bookDesController),
                                  _entryField('Amount', 'Enter Amount',
                                      (String amount) {
                                    getAmount(int.parse(amount));
                                  }, amountController),
                                ],
                              ),
                            ),
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
                              onPressed: () {
                                UpdateBook();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SellerNavBar()));
                              },
                              child: const Text('Update'),
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

Widget _entryField(String title, String hintText, Function(String) onChanged,
    TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
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
