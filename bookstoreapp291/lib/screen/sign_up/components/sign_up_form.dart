import 'package:bookstoreapp291/screen/login_success/login_success_screen.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/components/custom_surfix_icon.dart';
import 'package:bookstoreapp291/components/default_button.dart';
import 'package:bookstoreapp291/components/from_error.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookstoreapp291/screen/complete_profile/complete_profile_screen.dart';

import '../../../constants.dart';
import '../../../sizedConfig.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

String email = '';
String password = '';
String cpassword = '';

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool remember = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Future signUp() async {
      if (_formKey.currentState!.validate()) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim());

          await FirebaseFirestore.instance.collection("User").add({
            "UserId": emailController.text.trim(),
            "NameId": FirebaseFirestore.instance.collection("User").id,
            "firstName": "Please enter your firstname",
            "lastName": "Please enter your lastname",
            "addressName": "Please enter address",
            "emailName": emailController.text.trim(),
            "phoneNum": "Please enter your phone number",
            "payment": "Please enter payment address"
          });

          await FirebaseFirestore.instance
              .collection('usersProfilePic')
              .doc(emailController.text)
              .set(
                  {'email': emailController.text.trim(), 'userProfilePic': ''});

          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BottomNavBar();
          }));
        } on FirebaseAuthException catch (e) {
          print(e);
        }
      } else {
        print('invalid email or password');
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConfirmPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Continue",
            press: signUp,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginSuccessScreen())),
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: (password) {
        if (password == null) {
          return 'Please enter a password';
        } else if (password.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildConfirmPasswordFormField() {
    return TextFormField(
      controller: cpasswordController,
      obscureText: true,
      validator: (val) {
        if (val == null) {
          return 'Please Confirm your password';
        } else if (val != passwordController.text) {
          return 'Password does not match';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Confirm your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      validator: (email) {
        var emailReg = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
        if (email == null || email.isEmpty) {
          return 'Please enter a username';
        } else if (!emailReg.hasMatch(email)) {
          return 'Please enter a valid email';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}


// import 'package:bookstoreapp291/screen/login_success/login_success_screen.dart';
// import 'package:bookstoreapp291/widget/bottomNavBar.dart';
// import 'package:flutter/material.dart';
// import 'package:bookstoreapp291/components/custom_surfix_icon.dart';
// import 'package:bookstoreapp291/components/default_button.dart';
// import 'package:bookstoreapp291/components/from_error.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:bookstoreapp291/screen/complete_profile/complete_profile_screen.dart';

// import '../../../constants.dart';
// import '../../../sizedConfig.dart';

// class SignUpForm extends StatefulWidget {
//   @override
//   _SignUpFormState createState() => _SignUpFormState();
// }

// String email = '';
// String password = '';
// String cpassword = '';

// class _SignUpFormState extends State<SignUpForm> {
//   final _formKey = GlobalKey<FormState>();
//   bool remember = false;
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final cpasswordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     Future signUp() async {
//       if (_formKey.currentState!.validate()) {
//         try {
//           await FirebaseAuth.instance.createUserWithEmailAndPassword(
//               email: emailController.text.trim(),
//               password: passwordController.text.trim());
//           Navigator.push(context, MaterialPageRoute(builder: (context) {
//             return BottomNavBar();
//           }));
//         } on FirebaseAuthException catch (e) {
//           print(e);
//         }
//       } else {
//         print('invalid email or password');
//       }
//     }

//     return Form(
//       key: _formKey,
//       child: Column(
//         children: [
//           buildEmailFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildPasswordFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           buildConfirmPasswordFormField(),
//           SizedBox(height: getProportionateScreenHeight(30)),
//           DefaultButton(
//             text: "Continue",
//             press: signUp,
//             onPressed: () => Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => LoginSuccessScreen())),
//           ),
//         ],
//       ),
//     );
//   }

//   TextFormField buildPasswordFormField() {
//     return TextFormField(
//       controller: passwordController,
//       obscureText: true,
//       validator: (password) {
//         if (password == null) {
//           return 'Please enter a password';
//         } else if (password.length < 6) {
//           return 'Password must be at least 6 characters';
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "Password",
//         hintText: "Enter your password",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
//       ),
//     );
//   }

//   TextFormField buildConfirmPasswordFormField() {
//     return TextFormField(
//       controller: cpasswordController,
//       obscureText: true,
//       validator: (val) {
//         if (val == null) {
//           return 'Please Confirm your password';
//         } else if (val != passwordController.text) {
//           return 'Password does not match';
//         }
//         return null;
//       },
//       decoration: InputDecoration(
//         labelText: "Confirm Password",
//         hintText: "Confirm your password",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
//       ),
//     );
//   }

//   TextFormField buildEmailFormField() {
//     return TextFormField(
//       controller: emailController,
//       validator: (email) {
//         var emailReg = RegExp(
//             r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//         if (email == null || email.isEmpty) {
//           return 'Please enter a username';
//         } else if (!emailReg.hasMatch(email)) {
//           return 'Please enter a valid email';
//         }
//         return null;
//       },
//       keyboardType: TextInputType.emailAddress,
//       decoration: InputDecoration(
//         labelText: "Email",
//         hintText: "Enter your email",
//         floatingLabelBehavior: FloatingLabelBehavior.always,
//         suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
//       ),
//     );
//   }
// }
