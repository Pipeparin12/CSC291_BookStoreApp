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
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:form_field_validator/form_field_validator.dart';
import 'package:path/path.dart';
import 'package:path/path.dart' as path;

class AddBook extends StatefulWidget {
  AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final _formKey = GlobalKey<FormState>();
  late String bookName;
  late String bookDes;
  late int bookAmount;
  late String imageUrl;
  File? imageFile;
  final scrollController = ScrollController();
  final imagePicker = ImagePicker();

  void addBook() async {
    try {
      final formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          imageFile!.path,
          filename: "fileName.jpg",
          contentType: MediaType("image", "jpg"),
        ),
        "bookName": bookName,
        "bookDescription": bookDes,
        "bookAmount": bookAmount,
      });
      var result = await BookApi.addBook(formData);
    } catch (e) {}
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

  void pickedImage() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        imageFile = File(pick.path);
      } else {
        imageFile = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text('Add book for sale'),
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
                                  }),
                                  _entryField(
                                      'Description', 'Enter Description',
                                      (String des) {
                                    getBookDes(des);
                                  }),
                                  _entryField('Amount', 'Enter Amount',
                                      (String amount) {
                                    getAmount(int.parse(amount));
                                  }),
                                  // _entryField('Image', 'Enter Image URL',
                                  //     (String url) {
                                  //   getUrl(url);
                                  // }),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 40),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: SizedBox(
                                            height: 250,
                                            width: double.infinity,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                      width: 300,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          border: Border.all(
                                                              color: LightColor
                                                                  .grey)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Expanded(
                                                                child: imageFile ==
                                                                        null
                                                                    ? const Center(
                                                                        child: Text(
                                                                            'No image selected'),
                                                                      )
                                                                    : Image.file(
                                                                        imageFile!),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: [
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {
                                                                        pickedImage();
                                                                      },
                                                                      child: const Text(
                                                                          'Select Image')),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ],
                                            ),
                                          )))
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
                                    const EdgeInsets.all(10.0)),
                              ),
                              onPressed: () {
                                addBook();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SellerNavBar()));
                              },
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
          ),
        ));
  }
}

Widget _entryField(String title, String hintText, Function(String) onChanged) {
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
