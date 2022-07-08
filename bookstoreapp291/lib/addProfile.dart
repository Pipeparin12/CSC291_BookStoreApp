import 'package:bookstoreapp291/model/profile.dart';
import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProfile extends StatefulWidget {
  AddProfile({Key? key}) : super(key: key);

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  GlobalKey<FormState> formState = new GlobalKey<FormState>();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference Names = FirebaseFirestore.instance.collection("User");
  late String firstName;
  late String lastName;
  late String addressName;
  late String emailName;
  late String phoneNum;
  late String NameId;
  late String payment;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final addressNameController = TextEditingController();
  final emailNameController = TextEditingController();
  final phoneNumController = TextEditingController();
  final paymentController = TextEditingController();

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

  getPayment(String pay) {
    payment = pay;
  }

  createUserData(context) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('User').doc(NameId);

    Map<String, dynamic> User = ({
      "UserId": FirebaseAuth.instance.currentUser!.email,
      "NameId": NameId,
      "firstName": firstNameController.text.trim(),
      "lastName": lastNameController.text.trim(),
      "addressName": addressNameController.text.trim(),
      "emailName": emailNameController.text.trim(),
      "phoneNum": phoneNumController.text.trim(),
      "payment": paymentController.text.trim()
    });

    if (User != null) {
      documentReference.update(User).whenComplete(() {
        print('profile updated');
        Navigator.of(context).pop();
      });
    } else {
      print('error');
    }
  }

  void GetProfileInfo() async {
    FirebaseFirestore.instance
        .collection("User")
        .where("UserId", isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get()
        .then((snapshot) {
      final documents = snapshot.docs;
      if (documents != null) {
        Profile userProfile = Profile.fromJson(documents[0] as dynamic);
        print(userProfile.emailName);
        NameId = documents[0].id;
        setState(() {
          firstNameController.text = userProfile.firstName;
          lastNameController.text = userProfile.lastName;
          phoneNumController.text = userProfile.phoneNum;
          emailNameController.text = userProfile.emailName;
          addressNameController.text = userProfile.addressName;
          paymentController.text = userProfile.payment;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    GetProfileInfo();
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
    return FutureBuilder(
        future: firebase,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
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
                                        _entryField(
                                            'FirstName', 'Enter First Name',
                                            (String fname) {
                                          getFirstName(fname);
                                        }, firstNameController),
                                        _entryField(
                                            'LastName', 'Enter Lastname',
                                            (String lname) {
                                          getLastName(lname);
                                        }, lastNameController),
                                        _entryField('Address', 'Enter Address',
                                            (String aname) {
                                          getAddressName(aname);
                                        }, addressNameController),
                                        _entryField(
                                            'Phone', 'Enter Phone Number',
                                            (String pnum) {
                                          getPhoneNum(pnum);
                                        }, phoneNumController),
                                        _entryField(
                                            'Payment', 'Enter Payment Address',
                                            (String pay) {
                                          getPhoneNum(pay);
                                        }, paymentController),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 30.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        Colors.grey,
                                      ),
                                      padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(10.0),
                                      ),
                                    ),
                                    onPressed: () => createUserData(context),
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
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
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
