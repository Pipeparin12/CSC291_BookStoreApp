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
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  late String bookName;
  late String bookDes;
  late int bookPrice;
  late int bookAmount;
  String? imageUrl;
  File? imageFile;
  final scrollController = ScrollController();
  final imagePicker = ImagePicker();

  Future add() async {
    var res = await http.post(Uri.parse('http://10.0.2.2:8080/addBook'),
        headers: <String, String>{
          'Context-Type': 'application/json;charSet=UTF-8'
        },
        body: <String, String>{
          'bookName': bookName,
          'bookDescription': bookDes,
          'bookPrice': bookPrice.toString(),
          'bookAmount': bookAmount.toString(),
          'bookImage': imageUrl!
        });
    print(res.body);
  }

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

  Future pickedImage() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        imageFile = File(pick.path);
      } else {
        return null;
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
          key: formState,
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
                                  _entryField('Price', 'Enter Price',
                                      (String price) {
                                    getPrice(int.parse(price));
                                  }),
                                  _entryField('Amount', 'Enter Amount',
                                      (String amount) {
                                    getAmount(int.parse(amount));
                                  }),
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
                                                                  ElevatedButton(
                                                                      onPressed:
                                                                          () {},
                                                                      child: const Text(
                                                                          'Upload Image'))
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
                                add();
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
