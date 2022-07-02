import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:math';

import 'package:bookstoreapp291/model/book.dart';
import 'package:bookstoreapp291/model/product.dart';
import 'package:bookstoreapp291/sizedConfig.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
  // var nameController = TextEditingController();
  // var desController = TextEditingController();
  // var priceController = TextEditingController();
  // var amountController = TextEditingController();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference books = FirebaseFirestore.instance.collection("books");
  late String bookName;
  late String bookDes;
  late int bookPrice;
  late int bookAmount;
  late String bookId = FirebaseFirestore.instance.collection('books').doc().id;
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

  createBookData() async {
    debugPrint(bookId);
    debugPrint(bookName);
    debugPrint(bookDes);
    debugPrint(bookPrice.toString());
    debugPrint(bookAmount.toString());
    debugPrint(imageUrl);

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('books').doc(bookName);

    // create Map to send data in key:value pair form
    Map<String, dynamic> books = ({
      "sellerId": FirebaseAuth.instance.currentUser!.email,
      "bookId": bookId,
      "bookName": bookName,
      "bookDes": bookDes,
      "bookPrice": bookPrice,
      "bookAmount": bookAmount,
      "bookImage": imageUrl
    });

    // send data to Firebase
    if (books != null) {
      documentReference
          .set(books)
          .whenComplete(() => print('$bookName created'));
    } else {
      print('error');
    }
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

  Future<void> uploadImageToStorage() async {
    Reference ref =
        FirebaseStorage.instance.ref().child('bookImages/').child('/$bookName');

    await ref.putFile(imageFile!);
    imageUrl = await ref.getDownloadURL();
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
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
                                      padding:
                                          const EdgeInsets.only(bottom: 30),
                                      child: Column(
                                        children: [
                                          _entryField('Name', 'Enter Book Name',
                                              (String name) {
                                            getBookName(name);
                                          }),
                                          _entryField('Description',
                                              'Enter Description',
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
                                              padding: const EdgeInsets.only(
                                                  top: 40),
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
                                                                          .circular(
                                                                              20),
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
                                                                                child: Text('No image selected'),
                                                                              )
                                                                            : Image.file(imageFile!),
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          ElevatedButton(
                                                                              onPressed: () {
                                                                                pickedImage();
                                                                              },
                                                                              child: const Text('Select Image')),
                                                                          ElevatedButton(
                                                                              onPressed: () {
                                                                                uploadImageToStorage();
                                                                              },
                                                                              child: const Text('Upload Image'))
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
                                    padding:
                                        const EdgeInsets.only(bottom: 30.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(10.0)),
                                      ),
                                      onPressed: () => createBookData(),
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
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
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
