import 'dart:developer';

import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/widget/bookCard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookstoreapp291/screen/detail_book.dart';

import '../service/api/bookmark.dart';
import '../service/api/cart.dart';

class BookmarkPage extends StatefulWidget {
  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  var listBook = [];
  bool isLoading = true;

  Future<void> getYourBook() async {
    try {
      var result = await BookmarkApi.getBookmark();
      print(result.data);
      setState(() {
        listBook = result.data['book'].toList();
      });
      print(listBook);
    } on DioError catch (e) {
      print(e);
    }
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
        backgroundColor: Colors.grey,
        title: Text('Bookmark'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          height: 600,
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.all(10)),
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
                                    onPressed: () {}, icon: Icon(Icons.delete))
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
