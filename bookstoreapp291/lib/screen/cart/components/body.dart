import 'package:bookstoreapp291/screen/cart/components/check_out_card.dart';
import 'package:bookstoreapp291/screen/checkout/checkout_screen.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/widget/bookCard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../service/api/cart.dart';
import '../../../sizedConfig.dart';
import '../../../theme/light_color.dart';
import 'cart_card.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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

  Future<void> checkOut(String bookId, int amountInCart) async {
    try {
      var result = await CartApi.checkOut(bookId, amountInCart);
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<void> deleteCart(String cartId) async {
    try {
      var result = await CartApi.deleteCart(cartId);
      getYourBook();
    } on DioError catch (e) {
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Cart'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            height: 600,
            child: Column(children: <Widget>[
              Padding(padding: EdgeInsets.all(10)),
              Expanded(
                child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, bottom: 10),
                              height: 120,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: LightColor.lightGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: Image(
                                              image: NetworkImage(
                                                  DioInstance.getImage(
                                                      cart[index]['book']
                                                          ['bookImage'])))),
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text(
                                                cart[index]['bookName'],
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              Text("In cart: " +
                                                  cart[index]['amountInCart']
                                                      .toString()),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            deleteCart(cart[index]['_id']);
                                          },
                                          icon: Icon(Icons.delete))
                                    ]),
                              )),
                          // ElevatedButton(onPressed: (){
                          // checkOut(cart[index]['bookId'], cart[index]['amountinCart']);
                          // }, child: Text('CheckOut'))
                        ],
                      );
                    }),
              ),
            ]),
          ),
        ),
        bottomNavigationBar: Container(
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
                              for (int i = 0; i < cart.length; i++) {
                                checkOut(
                                    cart[i]['bookId'], cart[i]['amountInCart']);
                                deleteCart(cart[i]['_id']);
                              }
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
        ));
  }
}
