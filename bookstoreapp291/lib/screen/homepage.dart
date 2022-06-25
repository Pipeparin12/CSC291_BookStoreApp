import 'package:bookstoreapp291/model/product.dart';
import 'package:bookstoreapp291/screen/bookmark.dart';
import 'package:bookstoreapp291/screen/cart/cart_screen.dart';
import 'package:bookstoreapp291/screen/detail_book.dart';
import 'package:bookstoreapp291/screen/profile/components/profile.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/theme/theme.dart';
import 'package:bookstoreapp291/widget/bookCard.dart';
import 'package:bookstoreapp291/widget/extentions.dart';
import 'package:bookstoreapp291/widget/sellerNavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/screen/cart.dart';
import 'package:bookstoreapp291/widget/section_title.dart';

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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                      demoProducts.length,
                      (index) => bookCard(
                            product: demoProducts[index],
                            press: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailPage(
                                product: demoProducts[index],
                              );
                            })),
                          ))
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
              top: 30,
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.02),
              child: SectionTitle(title: 'New Release', press: () {}),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(
                      demoProducts.length,
                      (index) => bookCard(
                            product: demoProducts[index],
                            press: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailPage(
                                product: demoProducts[index],
                              );
                            })),
                          ))
                ],
              ),
            ),
          ],
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

// Widget _productShow() {
//   return SafeArea(child: child)
// }