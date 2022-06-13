import 'package:flutter/material.dart';
import 'package:bookstoreapp291/footer.dart';

class SellerCentre extends StatefulWidget {
  const SellerCentre({Key? key}) : super(key: key);

  @override
  State<SellerCentre> createState() => _SellerCentreState();
}

class _SellerCentreState extends State<SellerCentre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Centre'),
        centerTitle: true,
        backgroundColor: Colors.grey,
        leading: const Icon(Icons.add_shopping_cart_rounded),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Container(
              padding: EdgeInsets.all(20),
            ))
          ],
        ),
      ),
    );
  }
}
