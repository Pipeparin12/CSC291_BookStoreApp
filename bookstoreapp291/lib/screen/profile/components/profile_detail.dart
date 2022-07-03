import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../theme/light_color.dart';

class ProfileDetail extends StatefulWidget {
  var _profile;
  ProfileDetail(this._profile);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  Future addDetail() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("User");

Widget build(BuildContext context){
  return Scaffold(
    body: StreamBuilder(
    return _collectionRef.doc(currentUser!.email).collection("User").doc().set({
      "Firstname": widget._profile["firstName"],
      "Lastname": widget._profile["lastName"],
      "Email": widget._profile["emailName"],
      "Address": widget._profile["addressName"],
      "Phone": widget._profile["phoneNum"]
    )
  );
    
    }
  }
  }

