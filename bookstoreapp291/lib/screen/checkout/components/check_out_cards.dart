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

        return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
            itemBuilder: (_, index) {
              DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];

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
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              color: LightColor.grey)),
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
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                      child: const Text(
                                                          'Upload Bill'))
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
                        FirebaseFirestore.instance
                            .collection('users-cart-items')
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection('items')
                            .doc(_documentSnapshot.id)
                            .delete();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()));
                      },
                      child: Text('Confirm'))
                ],
              );
            });
      },
    );

    //   return Container(
    //     padding: EdgeInsets.symmetric(
    //       vertical: getProportionateScreenWidth(15),
    //       horizontal: getProportionateScreenWidth(30),
    //     ),
    //     // height: 174,
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(30),
    //         topRight: Radius.circular(30),
    //       ),
    //       boxShadow: [
    //         BoxShadow(
    //           offset: Offset(0, -15),
    //           blurRadius: 20,
    //           color: Color.fromARGB(255, 112, 111, 111).withOpacity(0.15),
    //         )
    //       ],
    //     ),
    //     child: SafeArea(
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Container(
    //                 child: SvgPicture.asset("assets/icons/receipt.svg"),
    //                 padding: EdgeInsets.all(10),
    //                 height: getProportionateScreenWidth(40),
    //                 width: getProportionateScreenWidth(40),
    //                 decoration: BoxDecoration(
    //                   color: Color(0xFFF5F6F9),
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //               ),
    //               (method == "Cash"
    //                   ? GestureDetector(
    //                       child: Text("Cash"),
    //                       onTap: () {
    //                         showModalBottomSheet(
    //                           context: context,
    //                           builder: ((Builder) => BottomSheet()),
    //                         );
    //                       })
    //                   : method == "Credit Card"
    //                       ? GestureDetector(
    //                           child: Text("Credit Card"),
    //                           onTap: () {
    //                             showModalBottomSheet(
    //                               context: context,
    //                               builder: ((Builder) => BottomSheet()),
    //                             );
    //                           })
    //                       : GestureDetector(
    //                           child: Text("Select Payment"),
    //                           onTap: () {
    //                             showModalBottomSheet(
    //                               context: context,
    //                               builder: ((Builder) => BottomSheet()),
    //                             );
    //                           })),
    //             ],
    //           ),
    //           SizedBox(height: getProportionateScreenHeight(20)),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text.rich(
    //                 TextSpan(
    //                   text: "Total:\n",
    //                   children: [
    //                     TextSpan(
    //                       text: "\$337.15",
    //                       style: TextStyle(fontSize: 16, color: Colors.black),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: getProportionateScreenWidth(190),
    //                 child: DefaultButton(
    //                   text: "Comfirm Payment",
    //                   press: () => Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => BottomNavBar())),
    //                   onPressed: () => Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                           builder: (context) => BottomNavBar())),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   );
    // }

    // Widget BottomSheet() {
    //   return Container(
    //     height: 140.0,
    //     margin: EdgeInsets.symmetric(
    //       horizontal: 20,
    //       vertical: 20,
    //     ),
    //     child: Column(
    //       children: <Widget>[
    //         Text(
    //           "Choose Payment Method",
    //           style: TextStyle(
    //             fontSize: 20.0,
    //           ),
    //         ),
    //         SizedBox(
    //           height: 50,
    //         ),
    //         Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    //           FlatButton.icon(
    //             icon: Icon(Icons.money),
    //             onPressed: () {
    //               setState(() {
    //                 method = "Cash";
    //               });
    //             },
    //             label: Text("Cash"),
    //           ),
    //           FlatButton.icon(
    //             icon: Icon(Icons.credit_card),
    //             onPressed: () {
    //               setState(() {
    //                 method = "Credit Card";
    //               });
    //             },
    //             label: Text("Credit card"),
    //           ),
    //         ])
    //       ],
    //     ),
    //   );
  }
}
