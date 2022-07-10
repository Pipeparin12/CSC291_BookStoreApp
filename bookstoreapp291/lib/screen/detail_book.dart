import 'package:bookstoreapp291/service/api/book.dart';
import 'package:bookstoreapp291/service/api/cart.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../service/api/bookmark.dart';

class BookDetail extends StatefulWidget {
  String? id;
  BookDetail({this.id, Key? key}) : super(key: key);

  @override
  State<BookDetail> createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  var listBook;
  bool isLoading = true;
  late int counter = 1;
  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      if (counter == 0) {
        return null;
      } else {
        counter--;
      }
    });
  }

  Future<void> getBook() async {
    try {
      print(widget.id);
      var result = await BookApi.getBook(widget.id!);
      setState(() {
        listBook = Map<String, dynamic>.from(result.data['book']);
        print(listBook);
        print(listBook['bookName']);
      });
      print(widget.id);
    } on DioError catch (e) {
      print(e);
    }
  }

  void addToCart() async {
    try {
      var result = await CartApi.addToCart(listBook['bookName'], counter,
          listBook['bookImage'], listBook['_id']);
    } catch (e) {}
  }

  void addToBookmark() async {
    try {
      var result = await BookmarkApi.addToBookmark(listBook['bookName'],
          listBook['bookAmount'], listBook['bookImage'], listBook['_id']);
    } catch (e) {}
  }

  @override
  void initState() {
    getBook().then((_) => Future.delayed(new Duration(seconds: 1), () {
          setState(() {
            isLoading = false;
          });
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Book Detail'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              backgroundColor: LightColor.darkgrey,
              child: IconButton(
                  onPressed: () {
                    addToBookmark();
                  },
                  icon: Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  )
                  //  Icon(
                  //     Icons.bookmark,
                  //     color: Colors.red,
                  //   ),
                  ),
            ),
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .6,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            DioInstance.getImage(listBook['bookImage'])),
                        fit: BoxFit.contain)),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * .45,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: LightColor.lightGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                listBook['bookName'],
                                style: GoogleFonts.ptSans(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: LightColor.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: Row(
                          children: [
                            Text(
                              "Amount : " + listBook['bookAmount'].toString(),
                              style: GoogleFonts.ptSans(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Text(listBook['bookDescription'].toString()),
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(20)),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                        child: Row(
                          children: [
                            Expanded(
                                child: Row(
                              children: [
                                Container(
                                  height: 49,
                                  width: 49,
                                  decoration: BoxDecoration(
                                      color: LightColor.skyBlue,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: TextButton(
                                    child: Text(
                                      '-',
                                      style: GoogleFonts.ptSans(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      decrement();
                                    },
                                  )),
                                ),
                                Container(
                                  height: 49,
                                  width: 70,
                                  child: Center(
                                      child: Text(
                                    '$counter',
                                    style: GoogleFonts.ptSans(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                Container(
                                  height: 49,
                                  width: 49,
                                  decoration: BoxDecoration(
                                      color: LightColor.skyBlue,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: TextButton(
                                    child: Text(
                                      '+',
                                      style: GoogleFonts.ptSans(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      increment();
                                    },
                                  )),
                                ),
                              ],
                            )),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: LightColor.iconColor,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text('Add to cart'),
                              ),
                              onTap: () {
                                addToCart();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
    );
  }
}
