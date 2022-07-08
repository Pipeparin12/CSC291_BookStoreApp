import 'dart:io';

import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import '../../../model/profile.dart';
import '../../../service/dio.dart';
import '../../../service/share_preference.dart';

class ProfilePic extends StatefulWidget {
  const ProfilePic({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  Profile userProfile = Profile(
    firstName: "-",
    lastName: "-",
    address: "-",
    email: "-",
    phone: "-",
    imageUrl: "",
  );
  String? imageUrl;
  File? imageFile;
  final imagePicker = ImagePicker();

  void fetchProfile() async {
    final token = SharePreference.prefs.getString("token");
    final response = await DioInstance.dio.get(
      "/auth/me",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    if (response.data["success"]) {
      setState(() {
        userProfile = Profile.fromJson(response.data["profile"]);
      });
    }

    print(response.data);
  }

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
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 115,
          width: 115,
          child: Stack(
            fit: StackFit.expand,
            clipBehavior: Clip.none,
            children: [
              userProfile.imageUrl != ''
                  ? ClipOval(
                      child: Image(
                        image: NetworkImage(userProfile.imageUrl),
                      ),
                    )
                  : const FlutterLogo(),
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
        ),
      ],
    ));
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
            ElevatedButton(onPressed: () {}, child: Text('upload'))
          ])
        ],
      ),
    );
  }
}
