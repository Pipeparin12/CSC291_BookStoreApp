import 'dart:developer';

import 'package:bookstoreapp291/model/product.dart';
import 'package:bookstoreapp291/screen/bookmark.dart';
import 'package:bookstoreapp291/screen/cart/cart_screen.dart';
import 'package:bookstoreapp291/screen/detail_book.dart';
import 'package:bookstoreapp291/screen/profile/profile_screen.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/theme/theme.dart';
import 'package:bookstoreapp291/widget/bookCard.dart';
import 'package:bookstoreapp291/widget/extentions.dart';
import 'package:bookstoreapp291/widget/sellerNavbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/widget/section_title.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainScreen> {
  List _books = [];
  var _firestoreInstace = FirebaseFirestore.instance;

  bookCard() async {
    QuerySnapshot qn = await _firestoreInstace.collection('books').get();
    setState(() {
      inspect(qn.docs);
      for (int i = 0; i < qn.docs.length; i++) {
        _books.add({
          "bookName": qn.docs[i]["bookName"],
          "bookDes": qn.docs[i]["bookDes"],
          "bookPrice": qn.docs[i]["bookPrice"],
          "bookAmount": qn.docs[i]["bookAmount"],
          "bookImage": qn.docs[i]["bookImage"]
        });
      }
    });

    return qn.docs;
  }

  @override
  void initState() {
    bookCard();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Store'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: IconButton(
            icon: Icon(Icons.sell),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SellerNavBar();
              }));
            }),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CartScreen();
              }));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: 600,
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 30)),
              _search(),
              Padding(
                  padding: EdgeInsets.only(
                top: 30,
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.02),
                child: SectionTitle(title: 'Best Seller', press: () {}),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _books.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, childAspectRatio: 1),
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BookDetail(_books[index]))),
                        child: Card(
                          elevation: 3,
                          child: Column(
                            children: [
                              AspectRatio(
                                aspectRatio: 2,
                                child: Container(
                                    color: LightColor.lightGrey,
                                    child: Image(
                                      image: NetworkImage(
                                          _books[index]['bookImage']),
                                      fit: BoxFit.contain,
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: Text(
                                  _books[index]["bookName"],
                                  style: GoogleFonts.abel(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(_books[index]["bookPrice"].toString()),
                            ],
                          ),
                        ),
                      );
                    }),
              ))
              // Padding(
              //     padding: EdgeInsets.only(
              //   top: 30,
              // )),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 0.02),
              //   child: SectionTitle(title: 'New Release', press: () {}),
              // ),
              // SingleChildScrollView(
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       ...List.generate(
              //           demoProducts.length,
              //           (index) => bookCard(
              //                 product: demoProducts[index],
              //                 press: () => Navigator.push(context,
              //                     MaterialPageRoute(builder: (context) {
              //                   return DetailPage(
              //                     product: demoProducts[index],
              //                   );
              //                 })),
              //               ))
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _search() {
  return Container(
    margin: AppTheme.padding,
    child: Row(
      children: <Widget>[
        Expanded(
            child: Container(
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: LightColor.lightGrey.withAlpha(100),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search",
                hintStyle: TextStyle(fontSize: 12),
                contentPadding:
                    EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 5),
                prefixIcon: Icon(Icons.search, color: Colors.black54)),
          ),
        ))
      ],
    ),
  );
}
