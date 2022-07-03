import 'package:bookstoreapp291/theme/light_color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
  late int phoneNum;
  late String NameId = FirebaseFirestore.instance.collection('User').doc().id;

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

  getPhoneNum(int pnum) {
    phoneNum = pnum;
  }

  createUserData() async {
    debugPrint(NameId);
    debugPrint(firstName);
    debugPrint(lastName);
    debugPrint(addressName);
    debugPrint(emailName);
    debugPrint(phoneNum.toString());

    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('User').doc(NameId);

    Map<String, dynamic> User = ({
      "UserId": FirebaseAuth.instance.currentUser!.email,
      "NameId": NameId,
      "firstName": firstName,
      "lastName": lastName,
      "addressName": addressName,
      "emailName": emailName,
      "phoneNum": phoneNum
    });

    if (User != null) {
      documentReference
          .set(User)
          .whenComplete(() => print('$firstName created'));
    } else {
      print('error');
    }
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
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  title: const Text('Add Profile'),
                  centerTitle: true,
                  backgroundColor: Colors.grey,
                ),
                body: Form(
                  key: formState,
                  child: CustomScrollView(
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
                                      padding:
                                          const EdgeInsets.only(bottom: 30),
                                      child: Column(
                                        children: [
                                          _entryField(
                                              'Name', 'Enter First Name',
                                              (String fname) {
                                            getFirstName(fname);
                                          }),
                                          _entryField('Name', 'Enter Lastname',
                                              (String lname) {
                                            getLastName(lname);
                                          }),
                                          _entryField(
                                              'Address', 'Enter Address',
                                              (String aname) {
                                            getAddressName(aname);
                                          }),
                                          _entryField('Email', 'Enter Email',
                                              (String ename) {
                                            getEmailName(ename);
                                          }),
                                          _entryField(
                                              'Phone', 'Enter Phone Number',
                                              (String pnum) {
                                            getPhoneNum(int.parse(pnum));
                                          }),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 40),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                border: Border.all(
                                                                    color: LightColor
                                                                        .grey)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 30.0),
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.grey),
                                        padding: MaterialStateProperty.all(
                                            const EdgeInsets.all(10.0)),
                                      ),
                                      onPressed: () => createUserData(),
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
                ));
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

Widget _entryField(String title, String hintText, Function(String) onChanged) {
  return Container(
    margin: const EdgeInsets.only(left: 30, right: 30, top: 15),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
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
