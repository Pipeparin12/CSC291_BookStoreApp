import 'dart:developer';

import 'package:bookstoreapp291/screen/bookmark.dart';
import 'package:bookstoreapp291/screen/cart/cart_screen.dart';
import 'package:bookstoreapp291/screen/detail_book.dart';
import 'package:bookstoreapp291/screen/profile/profile_screen.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/theme/theme.dart';
import 'package:bookstoreapp291/widget/bookCard.dart';
import 'package:bookstoreapp291/widget/extentions.dart';
import 'package:bookstoreapp291/widget/sellerNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/widget/section_title.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:bookstoreapp291/widget/search.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BookAround'),
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
      body: ,
    );
  }
}
