import 'package:bookstoreapp291/constants.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/model/profile.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/light_color.dart';
import 'package:bookstoreapp291/service/share_preference.dart';

class ProfileDetail extends StatefulWidget {
  const ProfileDetail({Key? key}) : super(key: key);

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  Profile userProfile = Profile(
    firstName: "-",
    lastName: "-",
    address: "-",
    email: "-",
    phone: "-",
    imageUrl: "",
  );

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

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 10),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 12, bottom: 10),
        decoration: BoxDecoration(
          color: LightColor.lightGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  " Firstname: ${userProfile.firstName}",
                  style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kSecondaryColor),
                )),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                " Lastname: ${userProfile.lastName}",
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                " Email: ${userProfile.email}",
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                " Phone: ${userProfile.phone}",
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                " Address: ${userProfile.address}",
                style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: kSecondaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
