import 'package:bookstoreapp291/model/profile.dart';
import 'package:bookstoreapp291/service/dio.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../service/share_preference.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({Key? key}) : super(key: key);

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late String firstName;
  late String lastName;
  late String addressName;
  late String emailName;
  late String phoneNum;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressNameController = TextEditingController();
  final emailNameController = TextEditingController();
  final phoneNumController = TextEditingController();
  final paymentController = TextEditingController();
  bool isLoading = true;

  getFirstName(String fname) {
    firstName = fname;
  }

  getLastName(String lname) {
    lastName = lname;
  }

  getAddressName(String aname) {
    addressName = aname;
  }

  getEmailName(String ename) {
    emailName = ename;
  }

  getPhoneNum(String pnum) {
    phoneNum = pnum;
  }

  updateProfile(context) async {
    Map<String, dynamic> updatedProfile = ({
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "address": addressNameController.text.trim(),
      "email": emailNameController.text.trim(),
      "phone": phoneNumController.text.trim(),
    });

    try {
      final token = SharePreference.prefs.getString("token");
      final response = await DioInstance.dio.patch(
        "/auth/me",
        data: updatedProfile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      print(response.data);

      if (response.data["success"]) {
        // Push to profile page
        Navigator.pushNamed(context, "/profile");
      }
    } catch (e) {
      print(e);
    }
  }

  void fetchProfile() async {
    print("Getting profile...");
    final token = SharePreference.prefs.getString("token");
    final response = await DioInstance.dio.get(
      "/auth/me",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );
    setState(() {
      isLoading = false;
    });

    if (response.data["success"]) {
      Profile userProfile = Profile.fromJson(response.data["profile"]);
      setState(() {
        setState(() {
          firstNameController.text = userProfile.firstName;
          lastNameController.text = userProfile.lastName;
          phoneNumController.text = userProfile.phone;
          emailNameController.text = userProfile.email;
          addressNameController.text = userProfile.address;
        });
      });
    }

    print(response.data);
  }

  // void fetchProfile() async {
  // FirebaseFirestore.instance
  //     .collection("User")
  //     .where("UserId", isEqualTo: FirebaseAuth.instance.currentUser!.email)
  //     .get()
  //     .then((snapshot) {
  //   final documents = snapshot.docs;
  //   if (documents != null) {
  //     Profile userProfile = Profile.fromJson(documents[0] as dynamic);
  //     print(userProfile.email);
  //     NameId = documents[0].id;
  //     setState(() {
  //       firstNameController.text = userProfile.firstName;
  //       lastNameController.text = userProfile.lastName;
  //       phoneNumController.text = userProfile.phone;
  //       emailNameController.text = userProfile.email;
  //       addressNameController.text = userProfile.address;
  //     });
  //   }
  // });
  // }

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumController.dispose();
    emailNameController.dispose();
    addressNameController.dispose();
    paymentController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: Colors.grey,
      ),
      body: Form(
        key: formState,
        child: CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  Expanded(
                      child: SizedBox(
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: Column(
                              children: [
                                _entryField('FirstName', 'Enter First Name',
                                    (String fname) {
                                  getFirstName(fname);
                                }, firstNameController),
                                _entryField('LastName', 'Enter Lastname',
                                    (String lname) {
                                  getLastName(lname);
                                }, lastNameController),
                                _entryField('Address', 'Enter Address',
                                    (String aname) {
                                  getAddressName(aname);
                                }, addressNameController),
                                _entryField('Phone', 'Enter Phone Number',
                                    (String pnum) {
                                  getPhoneNum(pnum);
                                }, phoneNumController),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                Colors.grey,
                              ),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.all(10.0),
                              ),
                            ),
                            onPressed: () => updateProfile(context),
                            child: const Text('Confirm'),
                          ),
                        )
                      ],
                    ),
                  )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _entryField(String title, String hintText, Function(String) onChanged,
    TextEditingController controller) {
  return Container(
    margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            controller: controller,
            obscureText: false,
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please enter the $title';
              }
              return null;
            },
            onChanged: onChanged,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              labelText: title,
              hintText: hintText,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        )
      ],
    ),
  );
}
