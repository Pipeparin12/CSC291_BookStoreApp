import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/screen/cart.dart';

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
        title: Text('Book Store'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: Icon(Icons.sell),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CartPage();
              }));
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 30)),
          _search()
        ],
      ),
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
            icon: Icon(Icons.bookmark_border),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Homepage',
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
