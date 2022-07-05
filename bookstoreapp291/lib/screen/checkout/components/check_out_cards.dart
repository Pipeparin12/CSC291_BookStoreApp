import 'dart:io';

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
  String? imageUrl;
  File? imageFile;
  final imagePicker = ImagePicker();
  int itemInCart = 0;
  int amount = 0;
  int book = 0;

  Future<void> updateAmount() async {}

  Future pickedImage() async {
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        imageFile = File(pick.path);
      } else {
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckOutScreeen'),
      ),
    );
  }
}
