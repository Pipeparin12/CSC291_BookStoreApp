import 'dart:io';

import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String? user_email = FirebaseAuth.instance.currentUser!.email;

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

  Future<void> uploadImageToStorage() async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('bill-images/')
        .child('/$user_email');

    await ref.putFile(imageFile!);
    imageUrl = await ref.getDownloadURL();
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users-cart-items')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('items')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Prompt Pay: 0912345678',
                      style: GoogleFonts.abel(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      'Kbank: 0312456789',
                      style: GoogleFonts.abel(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(
                      'SCB: 0612345789',
                      style: GoogleFonts.abel(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border:
                                          Border.all(color: LightColor.grey)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: imageFile == null
                                                ? const Center(
                                                    child: Text(
                                                        'No image selected'),
                                                  )
                                                : Image.file(imageFile!),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                  onPressed: () {
                                                    pickedImage();
                                                  },
                                                  child: const Text(
                                                      'Select Bill')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    uploadImageToStorage();
                                                  },
                                                  child:
                                                      const Text('Upload Bill'))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ))),
              Padding(padding: EdgeInsets.all(20)),
              ElevatedButton(
                  onPressed: () {
                    for (int i = 0; i < snapshot.data!.docs.length; i++) {
                      DocumentSnapshot _documentSnapshot =
                          snapshot.data!.docs[i];
                      FirebaseFirestore.instance
                          .collection('users-cart-items')
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .collection('items')
                          .doc(_documentSnapshot.id)
                          .delete();
                    }
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BottomNavBar()));
                  },
                  child: Text('Confirm'))
            ],
          );
        });
  }
}
