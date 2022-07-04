import 'dart:io';

import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  String? imageUrl;
  File? imageFile;
  final imagePicker = ImagePicker();
  String? user_email = FirebaseAuth.instance.currentUser!.email;
  DocumentReference docChecker = FirebaseFirestore.instance
      .collection('usersProfilePic')
      .doc(FirebaseAuth.instance.currentUser!.email);

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
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('usersProfilePic')
        .doc(user_email);

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profile-Images/')
        .child('/$user_email');

    await ref.putFile(imageFile!);
    imageUrl = await ref.getDownloadURL();
    print(imageUrl);

    documentReference.set({'email': user_email, 'userProfilePic': imageUrl});
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('usersProfilePic')
          .where('email', isEqualTo: user_email)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            DocumentSnapshot documentSnapshot = snapshot.data!.docs[index];
            return SizedBox(
              height: 115,
              width: 115,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  documentSnapshot['userProfilePic'] != ''
                      ? ClipOval(
                          child: Image(
                              image: NetworkImage(
                                  documentSnapshot['userProfilePic'])))
                      : FlutterLogo(),
                  Positioned(
                    right: 100,
                    bottom: 0,
                    child: SizedBox(
                        height: 46,
                        width: 46,
                        child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((Builder) => BottomSheet()),
                              );
                            },
                            child: Icon(
                              Icons.camera_alt,
                              color: LightColor.grey,
                              size: 28.0,
                            ))),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget BottomSheet() {
    return Container(
      height: 100.0,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                pickedImage();
              },
              label: Text("Gallery"),
            ),
            ElevatedButton(
                onPressed: () {
                  uploadImageToStorage();
                },
                child: Text('upload'))
          ])
        ],
      ),
    );
  }
}
