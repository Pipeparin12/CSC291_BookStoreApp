import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/Profile Image.png"),
          ),
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
                    color: Colors.grey,
                    size: 28.0,
                  )),
            ),
          )
        ],
      ),
    );
  }
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
            onPressed: () {},
            label: Text("Camera"),
          ),
          FlatButton.icon(
            icon: Icon(Icons.image),
            onPressed: () {},
            label: Text("Gallery"),
          ),
        ])
      ],
    ),
  );
}
