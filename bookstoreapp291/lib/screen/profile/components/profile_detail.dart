import 'package:bookstoreapp291/constants.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/model/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/light_color.dart';

class ProfileDetail extends StatefulWidget {
  var _profile;
  ProfileDetail(this._profile);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProfileDetail'),
      ),
    );
  }
}
