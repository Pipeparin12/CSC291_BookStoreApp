import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  const AddBook({Key? key}) : super(key: key);

  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add book for sale'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: const Icon(Icons.arrow_back),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Column(
              children: [
                Expanded(child: _allEntryFieldWidget()),
              ],
            )),
            footer()
          ],
        ),
      ),
    );
  }
}

int _selectedIndex = 0;

class footer extends StatefulWidget {
  const footer({Key? key}) : super(key: key);

  @override
  State<footer> createState() => _footerState();
}

class _footerState extends State<footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

// Widget textformfield({@required hintText}) {
//   final InputDecoration textFormStyle = InputDecoration(
//     hintText: hintText,
//     border: const OutlineInputBorder(),
//     hintStyle:
//         const TextStyle(letterSpacing: 1, fontSize: 20, color: Colors.black),
//   );
//   return Material(
//     elevation: 2,
//     child: TextField(
//       enabled: true,
//       textAlign: TextAlign.center,
//       decoration: textFormStyle,
//     ),
//   );
// }

Widget _allEntryFieldWidget() {
  return Column(
    children: <Widget>[
      _entryField("Name"),
      _entryField("Description"),
      _entryField("Price"),
      _entryField("Amount"),
    ],
  );
}

Widget _entryField(String title) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Color(0xfff3f3f4),
                filled: true))
      ],
    ),
  );
}
