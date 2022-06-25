import 'package:bookstoreapp291/model/product.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key, required this.product}) : super(key: key);
  static String routeName = "/details";
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Detail Book'),
        centerTitle: true,
      ),
      body: Stack(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .6,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(product.images), fit: BoxFit.contain)),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: MediaQuery.of(context).size.height * .4,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: LightColor.lightGrey,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: GoogleFonts.ptSans(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: LightColor.black),
                        ),
                      ),
                      Icon(Icons.bookmark_border)
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    children: [
                      Text(
                        product.price.toString(),
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
                    child: Text(product.description),
                  ),
                ),
                Padding(padding: EdgeInsets.all(20)),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
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
                                child: Text(
                              '-',
                              style: GoogleFonts.ptSans(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ),
                          Container(
                            height: 49,
                            width: 70,
                            child: Center(
                                child: Text(
                              '1',
                              style: GoogleFonts.ptSans(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ),
                          Container(
                            height: 49,
                            width: 49,
                            decoration: BoxDecoration(
                                color: LightColor.skyBlue,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                                child: Text(
                              '+',
                              style: GoogleFonts.ptSans(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                          ),
                        ],
                      )),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        decoration: BoxDecoration(
                            color: LightColor.iconColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text('Add to cart'),
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