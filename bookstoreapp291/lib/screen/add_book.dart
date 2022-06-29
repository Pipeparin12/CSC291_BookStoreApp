import 'dart:convert';
import 'dart:io' as io;
import 'dart:io';
import 'dart:math';

import 'package:bookstoreapp291/model/book.dart';
import 'package:bookstoreapp291/model/product.dart';
import 'package:bookstoreapp291/sizedConfig.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  late String url;
  File? imageFile;
  final scrollController = ScrollController();

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

  createBookData() {
    debugPrint(FirebaseFirestore.instance.collection('books').id);
    debugPrint(bookName);
    debugPrint(bookDes);
    debugPrint(bookPrice.toString());
    debugPrint(bookAmount.toString());

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('books').doc(bookName);

    // create Map to send data in key:value pair form
    Map<String, dynamic> books = ({
      "bookId": FirebaseFirestore.instance.collection('books').doc().id,
      "bookName": bookName,
      "bookDes": bookDes,
      "bookPrice": bookPrice,
      "bookAmount": bookAmount,
      "bookImage": imageFile!.path
    });

    // send data to Firebase
    if (books != null) {
      uploadImageToStorage();
      documentReference
          .set(books)
          .whenComplete(() => print('$bookName created'));
    } else {
      print('error');
    }
  }

  Future pickedImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile != null) {
      imageFile = File(xFile.path);
    }
  }

  Future<void> uploadImageToStorage() async {
    if (imageFile == null) {
      print('No file was selected');
      return null;
    }

    UploadTask uploadTask;

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('bookImages/')
        .child('/$bookName.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpg',
      customMetadata: {'picked-file-path': imageFile!.path},
    );

    if (kIsWeb) {
      uploadTask = ref.putData(await imageFile!.readAsBytes(), metadata);
    } else {
      uploadTask = ref.putFile(io.File(imageFile!.path), metadata);
    }
  }

  // @override
  // void dispose() {
  //   nameController.dispose();
  //   desController.dispose();
  //   priceController.dispose();
  //   amountController.dispose();
  //   super.dispose();
  // }

  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  // void _decrementCounter() {
  //   setState(() {
  //     _counter--;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Error'),
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
                                          // Expanded(
                                          //     child: Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.center,
                                          //   children: [
                                          //     Text('Amount'),
                                          //     RoundedIconBtn(
                                          //       icon: Icons.remove,
                                          //       press: () {
                                          //         _decrementCounter();
                                          //       },
                                          //     ),
                                          //     Text('$_counter'),
                                          //     RoundedIconBtn(
                                          //       icon: Icons.add,
                                          //       showShadow: true,
                                          //       press: () {
                                          //         _incrementCounter();
                                          //       },
                                          //     ),
                                          //   ],
                                          // )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 40),
                                            child: IconButton(
                                                onPressed: () {
                                                  pickedImage();
                                                },
                                                iconSize: 80,
                                                icon: Icon(Icons
                                                    .add_a_photo_outlined)),
                                          )
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
          return Scaffold(
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
          child: TextField(
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

// class RoundedIconBtn extends StatelessWidget {
//   const RoundedIconBtn({
//     Key? key,
//     required this.icon,
//     required this.press,
//     this.showShadow = false,
//   }) : super(key: key);

//   final IconData icon;
//   final GestureTapCancelCallback press;
//   final bool showShadow;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         boxShadow: [
//           if (showShadow)
//             BoxShadow(
//               offset: Offset(0, 6),
//               blurRadius: 10,
//               color: Color(0xFFB0B0B0).withOpacity(0.2),
//             ),
//         ],
//       ),
//       child: IconButton(
//         color: LightColor.grey,
//         onPressed: press,
//         icon: Icon(icon),
//       ),
//     );
//   }
// }
