import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bookstoreapp291/components/default_button.dart';

import '../../../constants.dart';
import '../../../sizedConfig.dart';

class CheckoutsCard extends StatefulWidget {
  CheckoutsCard({Key? key}) : super(key: key);

  @override
  State<CheckoutsCard> createState() => CheckoutsCardState();
}

class CheckoutsCardState extends State<CheckoutsCard> {
  String method = "None";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: getProportionateScreenWidth(15),
        horizontal: getProportionateScreenWidth(30),
      ),
      // height: 174,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color.fromARGB(255, 112, 111, 111).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: SvgPicture.asset("assets/icons/receipt.svg"),
                  padding: EdgeInsets.all(10),
                  height: getProportionateScreenWidth(40),
                  width: getProportionateScreenWidth(40),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                (method == "Cash"
                    ? GestureDetector(
                        child: Text("Cash"),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((Builder) => BottomSheet()),
                          );
                        })
                    : method == "Credit Card"
                        ? GestureDetector(
                            child: Text("Credit Card"),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((Builder) => BottomSheet()),
                              );
                            })
                        : GestureDetector(
                            child: Text("Select Payment"),
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((Builder) => BottomSheet()),
                              );
                            })),
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: "Total:\n",
                    children: [
                      TextSpan(
                        text: "\$337.15",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: getProportionateScreenWidth(190),
                  child: DefaultButton(
                    text: "Comfirm Payment",
                    press: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavBar())),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavBar())),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget BottomSheet() {
    return Container(
      height: 140.0,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Payment Method",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.money),
              onPressed: () {
                setState(() {
                  method = "Cash";
                });
              },
              label: Text("Cash"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.credit_card),
              onPressed: () {
                setState(() {
                  method = "Credit Card";
                });
              },
              label: Text("Credit card"),
            ),
          ])
        ],
      ),
    );
  }
}
