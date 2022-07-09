import 'dart:io';
import 'dart:ui';

import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:bookstoreapp291/components/default_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants.dart';
import '../../../sizedConfig.dart';
import '../../../theme/light_color.dart';

class CheckoutsCard extends StatefulWidget {
  CheckoutsCard({Key? key}) : super(key: key);

  @override
  State<CheckoutsCard> createState() => CheckoutsCardState();
}

class CheckoutsCardState extends State<CheckoutsCard> {
  String method = "None";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Checkout',
          style: GoogleFonts.kanit(),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          height: 300,
          width: 400,
          alignment: Alignment.center,
          child: Text(
            'Thanks!',
            style: GoogleFonts.kanit(fontSize: 30, color: Colors.white),
          ),
          color: LightColor.darkgrey,
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                    child: Icon(
                  Icons.check,
                  size: 100,
                )),
                Container(
                  child: Text(
                    'Thank you for choosing us.',
                    style: GoogleFonts.kanit(
                        fontSize: 18, color: LightColor.darkgrey),
                  ),
                ),
                Container(
                  child: Text(
                    'Your order will be shipping around 2-4 days',
                    style:
                        GoogleFonts.kanit(fontSize: 12, color: LightColor.grey),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar()));
                    },
                    child: Text(
                      'Go to Homepage',
                      style: GoogleFonts.kanit(),
                    ))
              ],
            ),
          ),
        )
      ]),
    );
  }
}
