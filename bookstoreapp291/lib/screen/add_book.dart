import 'package:bookstoreapp291/size_config.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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

  int _counter = 0;

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
                                              nameController),
                                          _entryField(
                                              'Description',
                                              'Enter Description',
                                              nameController),
                                          _entryField('Price', 'Enter Price',
                                              nameController),
                                          Expanded(
                                              child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text('Amount'),
                                              RoundedIconBtn(
                                                icon: Icons.remove,
                                                press: () {
                                                  _decrementCounter();
                                                },
                                              ),
                                              Text('$_counter'),
                                              RoundedIconBtn(
                                                icon: Icons.add,
                                                showShadow: true,
                                                press: () {
                                                  _incrementCounter();
                                                },
                                              ),
                                            ],
                                          )),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 50),
                                            child: IconButton(
                                                onPressed: () {},
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
                                      onPressed: () {
                                        String name = nameController.text;
                                        String description = desController.text;
                                        int price =
                                            int.parse(priceController.text);
                                        int amount =
                                            int.parse(amountController.text);
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

Widget _entryField(
  String title,
  String hintText,
  TextEditingController controller,
) {
  return Container(
    margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
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
