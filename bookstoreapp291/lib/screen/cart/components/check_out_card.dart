import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bookstoreapp291/components/default_button.dart';
import 'package:bookstoreapp291/screen/checkout/checkout_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../service/api/cart.dart';
import '../../../sizedConfig.dart';

class CheckoutCard extends StatefulWidget {
  const CheckoutCard({Key? key}) : super(key: key);

  @override
  State<CheckoutCard> createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {
  var cart = [];
  bool isLoading = true;

  Future<void> getYourBook() async {
    try {
      var result = await CartApi.getCart();
      print(result.data);
      setState(() {
        cart = result.data['carts'].toList();
      });
      print(cart);
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<void> checkOut() async {
    try {} on DioError catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getYourBook();
    super.initState();
  }

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
            color: Color(0xFFDADADA).withOpacity(0.15),
          )
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: getProportionateScreenHeight(20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                    width: getProportionateScreenWidth(310),
                    child: ElevatedButton(
                        child: Text("Check Out"),
                        onPressed: () {
                          checkOut();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CheckoutScreen()));
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
