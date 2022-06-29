import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? Images;

  Future pickImage() async {
    try {
      final Images = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (Images == null) return;

      final imageTemp = File(Images.path);

      setState(() => this.Images = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final Images = await ImagePicker().pickImage(source: ImageSource.camera);

      if (Images == null) return;

      final imageTemp = File(Images.path);

      setState(() => this.Images = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Images != null ? Image.file(Images!) : FlutterLogo(),
          Positioned(
            right: -16,
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
                      color: Colors.orange,
                      size: 28.0,
                    ))),
          )
        ],
      ),
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
              icon: Icon(Icons.camera),
              onPressed: () {
                pickImageC();
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                pickImage();
              },
              label: Text("Gallery"),
            ),
            SizedBox(height: 20),
            Images != null ? Image.file(Images!) : Text(" No image Selected"),
          ])
        ],
      ),
    );
  }
}
