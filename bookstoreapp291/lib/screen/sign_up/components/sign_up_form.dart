import 'package:bookstoreapp291/screen/sign_in/sign_in_screen.dart';
import 'package:bookstoreapp291/service/api/user.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/components/custom_surfix_icon.dart';
import 'package:bookstoreapp291/components/default_button.dart';
import 'package:bookstoreapp291/components/from_error.dart';
import 'package:http/http.dart' as http;
import 'package:bookstoreapp291/model/user.dart';

import '../../../constants.dart';
import '../../../sizedConfig.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool isloading = false;
  bool remember = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();

  void signUpHandler() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      try {
        var result =
            await UserApi.signUp(emailController.text, passwordController.text);
      } on DioError catch (e) {
        setState(() {
          isloading = false;
        });
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            press: signUpHandler,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen())),
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
