import 'package:bookstoreapp291/widget/section_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/theme/light_color.dart';

class bookCard extends StatelessWidget {
  const bookCard(
      {Key? key, required this.name, required this.price, required this.image})
      : super(key: key);
  final String name;
  final int price;
  final String image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
            top: 30,
          )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.02),
            child: SectionTitle(title: 'Popular Book', press: () {}),
          ),
          Padding(padding: EdgeInsets.only(top: 25)),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                    width: 140,
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1.02,
                          child: Container(
                            decoration: BoxDecoration(
                                color: LightColor.lightGrey,
                                borderRadius: BorderRadius.circular(15)),
                            child: Image.asset(image),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Text(
                          this.name,
                          style: TextStyle(
                              color: LightColor.titleTextColor, fontSize: 15),
                          maxLines: 2,
                        ),
                        Padding(padding: EdgeInsets.only(top: 5)),
                        Row(
                          children: [
                            Text(
                              this.price.toString(),
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
            ],
          ),
        ],
      )),
    );
  }
}
