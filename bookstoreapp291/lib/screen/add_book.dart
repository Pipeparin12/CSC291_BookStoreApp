import 'package:bookstoreapp291/model/book.dart';
import 'package:bookstoreapp291/model/product.dart';
import 'package:bookstoreapp291/sizedConfig.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:path/path.dart';

class AddBook extends StatefulWidget {
  AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final desController = TextEditingController();
  final priceController = TextEditingController();
  final amountController = TextEditingController();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _bookCollection =
      FirebaseFirestore.instance.collection("books");
  Book myBook = Book();

  int _counter = 0;

  Future pickImage() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

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
                  key: formKey,
                  child: CustomScrollView(
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
                                              nameController, (String name) {
                                            myBook.name = name;
                                          },
                                              RequiredValidator(
                                                  errorText:
                                                      "Please enter name")),
                                          _entryField(
                                              'Description',
                                              'Enter Description',
                                              nameController,
                                              (String description) {
                                            myBook.description = description;
                                          },
                                              RequiredValidator(
                                                  errorText:
                                                      "Please enter description")),
                                          _entryField('Price', 'Enter Price',
                                              nameController, (String price) {
                                            myBook.price = price;
                                          },
                                              RequiredValidator(
                                                  errorText:
                                                      "Please enter price")),
                                          _entryField('Amount', 'Enter Amount',
                                              nameController, (int amount) {
                                            myBook.amount =
                                                int.parse(amount.toString());
                                          },
                                              RequiredValidator(
                                                  errorText:
                                                      "Please enter amount")),
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
                                                onPressed: () => pickImage(),
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
                                      onPressed: () async {
                                        if (formKey.currentState!.validate()) {
                                          formKey.currentState!.save();
                                          await _bookCollection.add({
                                            "name": myBook.name,
                                            "description": myBook.description,
                                            "price": myBook.price,
                                            "amount": myBook.amount,
                                            "image": myBook.image
                                          });
                                          formKey.currentState!.reset();
                                        }
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
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

Widget _entryField(String title, String hintText,
    TextEditingController controller, Function onSaved, Function validator) {
  return Container(
    margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
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

class RoundedIconBtn extends StatelessWidget {
  const RoundedIconBtn({
    Key? key,
    required this.icon,
    required this.press,
    this.showShadow = false,
  }) : super(key: key);

  final IconData icon;
  final GestureTapCancelCallback press;
  final bool showShadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          if (showShadow)
            BoxShadow(
              offset: Offset(0, 6),
              blurRadius: 10,
              color: Color(0xFFB0B0B0).withOpacity(0.2),
            ),
        ],
      ),
      child: IconButton(
        color: LightColor.grey,
        onPressed: press,
        icon: Icon(icon),
      ),
    );
  }
}
