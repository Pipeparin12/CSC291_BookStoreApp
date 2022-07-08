import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:bookstoreapp291/components/default_button.dart';
import 'package:bookstoreapp291/screen/checkout/checkout_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../../../sizedConfig.dart';

class CheckoutCard extends StatelessWidget {
  const CheckoutCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('checkout')),
    );
  }
}
