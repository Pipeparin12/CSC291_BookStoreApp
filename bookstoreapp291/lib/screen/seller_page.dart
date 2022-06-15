import 'dart:ui';

import 'package:bookstoreapp291/screen/add_book.dart';
import 'package:flutter/material.dart';

class SellerCentre extends StatefulWidget {
  const SellerCentre({Key? key}) : super(key: key);

  @override
  State<SellerCentre> createState() => _SellerCentreState();
}

class _SellerCentreState extends State<SellerCentre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Centre'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: const Icon(Icons.add_shopping_cart_rounded),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(10)),
            const Text(
              'Your sell book list',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Box(amount: 1, price: 200, name: "Book01"),
                Box(amount: 2, price: 400, name: "Book02")
              ],
            )),
            footer()
          ],
        ),
      ),
    );
  }
}

class Box extends StatefulWidget {
  final int amount;
  final int price;
  // -
  final String name;
  const Box(
      {Key? key,
      required this.amount,
      required this.price,
      // required this.pic,
      required this.name})
      : super(key: key);

  @override
  State<Box> createState() => _BoxState(
        amount: this.amount,
        price: this.price,
        // pic: this.pic,
        name: this.name,
      );
}

class _BoxState extends State<Box> {
  int amount;
  int price;
  // String pic;
  String name;

  _BoxState(
      {required this.amount,
      required this.price,
      // required this.pic,
      required this.name});

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 350,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: const Border(
            top: BorderSide(width: 1.0, color: Colors.black),
            left: BorderSide(width: 1.0, color: Colors.black),
            right: BorderSide(width: 1.0, color: Colors.black),
            bottom: BorderSide(width: 1.0, color: Colors.black),
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ClipRRect(
          //   // borderRadius: BorderRadius.all(Radius.circular(10)),
          //   child: Image.asset(
          //     pic,
          //   ),
          // ),

          // child: Text(
          //     'Bookname :' + ' ' + name,
          //     style: const TextStyle(
          //         fontSize: 13,
          //         color: Colors.black,
          //         decoration: TextDecoration.none),
          //     textAlign: TextAlign.center,
          //   ),
          //   width: 120,
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Bookname : " + name),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Price : $price"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Amount : $amount"),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class footer extends StatefulWidget {
  const footer({Key? key}) : super(key: key);

  @override
  State<footer> createState() => _footerState();
}

class _footerState extends State<footer> {
  int _selectedIndex = 0;
  final widgetOptions = [
    new SellerCentre(),
    new AddBook(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 15,
        selectedIconTheme: IconThemeData(color: Colors.grey[850]),
        selectedItemColor: Colors.grey[850],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'SellerCentre',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'AddBook',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
