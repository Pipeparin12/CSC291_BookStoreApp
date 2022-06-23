import 'package:bookstoreapp291/widget/section_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:bookstoreapp291/model/product.dart';

class bookCard extends StatelessWidget {
  const bookCard({Key? key, required this.product, required this.press})
      : super(key: key);
  final Product product;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 25)),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: press,
                  child: SizedBox(
                      width: 140,
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1.02,
                            child: SizedBox(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: LightColor.lightGrey,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Image.asset(product.images),
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Text(
                            product.name,
                            style: TextStyle(
                                color: LightColor.titleTextColor, fontSize: 15),
                            maxLines: 2,
                            textAlign: TextAlign.left,
                          ),
                          Padding(padding: EdgeInsets.only(top: 5)),
                          Row(
                            children: [
                              Text(
                                product.price.toString(),
                                style: TextStyle(
                                  color: LightColor.orange,
                                  fontSize: 15,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                              Container()
                            ],
                          )
                        ],
                      )),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
