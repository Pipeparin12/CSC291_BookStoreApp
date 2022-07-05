import 'dart:developer';

import 'package:bookstoreapp291/widget/section_title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../detail_book.dart';

@override
Widget cartCard(String collectionName) {
  return Scaffold(
    appBar: AppBar(title: Text('Cart')),
  );
}
