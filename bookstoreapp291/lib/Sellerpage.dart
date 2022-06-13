import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

int _selectedIndex = 0;

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
        title: Text('Seller centre'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: Icon(Icons.add_shopping_cart_rounded),
      ),
      body: Center(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedFontSize: 15,
        selectedIconTheme: IconThemeData(color: Colors.grey[850]),
        selectedItemColor: Colors.grey[850],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedIconTheme: IconThemeData(color: Colors.grey),
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
