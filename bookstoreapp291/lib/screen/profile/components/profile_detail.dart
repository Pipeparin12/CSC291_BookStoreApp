import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('User')
            .where('UserId',
                isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          final documents = (snapshot.data as dynamic)?.docs;

          if (snapshot.data == null || documents == null) {
            return Text("No data");
          }

          Profile userProfile = Profile.fromJson(documents[0] as dynamic);

          // Profile userProfile = profiles[0];

          return Column(
            children: [
              Text(
                " Firstname: ${userProfile.firstName}",
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                " Lastname: ${userProfile.lastName}",
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                " Email: ${userProfile.emailName}",
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                " Phone: ${userProfile.phoneNum}",
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                " Address: ${userProfile.addressName}",
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                " Payment: ${userProfile.payment}",
                style: GoogleFonts.roboto(
                    fontSize: 15, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          );
        });
  }
}
