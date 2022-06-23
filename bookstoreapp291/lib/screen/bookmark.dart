import 'package:bookstoreapp291/model/product.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class BookmarkPage extends StatelessWidget {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Bookmark'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 30)),
            ...List.generate(demoProducts.length, (index) {
              if (demoProducts[index].isBookmark)
                return BookmarkBox(product: demoProducts[index]);

              return SizedBox.square();
            }),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class BookmarkBox extends StatelessWidget {
  const BookmarkBox({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        height: 120,
        child: Container(
            decoration: BoxDecoration(
                color: LightColor.lightGrey,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      product.images,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(product.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(product.price.toString()),
                            ],
                          )))
                ])));
  }
}
