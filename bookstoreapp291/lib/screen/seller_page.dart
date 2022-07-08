import 'dart:developer';
import 'dart:ui';

import 'package:bookstoreapp291/screen/edit_book.dart';
import 'package:bookstoreapp291/screen/homepage.dart';
import 'package:bookstoreapp291/service/api/book.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:bookstoreapp291/widget/sellerCard.dart';
import 'package:bookstoreapp291/widget/sellerNavbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class SellerCentre extends StatefulWidget {
  const SellerCentre({Key? key}) : super(key: key);

  @override
  State<SellerCentre> createState() => _SellerCentreState();
}

class _SellerCentreState extends State<SellerCentre> {
  var listBook = [];
  bool isLoading = true;

  Future<void> getYourBook() async {
    try {
      var result = await BookApi.getYourBook();
      setState(() {
        listBook = result.data['book'].toList();
      });
      print(listBook);
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<void> deleteBook(String bookId) async {
    try {
      var result = await BookApi.deleteBook(bookId);
    } on DioError catch (e) {
      print(e);
    }
  }

  void showUpdatePage(String id) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditBook(
                  id: id,
                )));
  }

  @override
  void initState() {
    getYourBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donate Centre'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BottomNavBar();
            }));
          },
          icon: Icon(Icons.add_shopping_cart),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: 600,
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
            Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 15.0),
              child: const Text(
                'Your donate book list',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: listBook.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        padding:
                            EdgeInsets.only(right: 20, left: 20, bottom: 10),
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
                                  // child: Image(
                                  //     image: NetworkImage(
                                  //         listBook[index]['bookImage']))
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(listBook[index]['bookName'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        Text("Amount: " +
                                            listBook[index]['bookAmount']
                                                .toString()),
                                      ],
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showUpdatePage(listBook[index]['_id']);
                                    // showDialog(
                                    //     context: context,
                                    //     builder: (BuildContext context) {
                                    //       return AlertDialog(
                                    //         backgroundColor:
                                    //             LightColor.lightGrey,
                                    //         scrollable: true,
                                    //         title: Text('Edit'),
                                    //         content: Padding(
                                    //           padding: EdgeInsets.all(8.0),
                                    //           child: Form(
                                    //             child: Column(
                                    //               children: <Widget>[
                                    //                 _entryField("Name",
                                    //                     bookNameController),
                                    //                 _entryField("Description",
                                    //                     bookDesController),
                                    //                 _entryField("Amount",
                                    //                     bookPriceController),
                                    //                 _entryField("Image",
                                    //                     bookAmountController),
                                    //               ],
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         actions: [
                                    //           Padding(
                                    //             padding: EdgeInsets.all(15.0),
                                    //             child: ElevatedButton(
                                    //               onPressed: () {},
                                    //               child: Text('Save'),
                                    //             ),
                                    //           )
                                    //         ],
                                    //       );
                                    //     });
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                    onPressed: () {
                                      deleteBook(listBook[index]['_id']);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SellerNavBar()));
                                    },
                                    icon: Icon(Icons.delete))
                              ]),
                        ));
                  }),
            ),
          ]),
        ),
      ),
    );
  }
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
