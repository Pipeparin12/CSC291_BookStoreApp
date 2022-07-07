import 'package:bookstoreapp291/screen/seller_page.dart';
import 'package:bookstoreapp291/service/api/user.dart';
import 'package:bookstoreapp291/widget/bottomNavBar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/components/custom_surfix_icon.dart';
import 'package:bookstoreapp291/components/from_error.dart';
import 'package:http/http.dart' as http;
import 'package:bookstoreapp291/model/user.dart';

import 'package:bookstoreapp291/screen/forgot_password/forgot_password_screen.dart';

import '../../../components/default_button.dart';
import '../../../constants.dart';
import '../../../sizedConfig.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool? isLoading = false;
  bool? remember = false;

  void signInHandler() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      try {
        var result =
            await UserApi.signIn(emailController.text, passwordController.text);
      } on DioError catch (e) {
        setState(() {
          isLoading = false;
        });
        print(e);
      }
    }
  }

  User user = User('', '');
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
          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen())),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(60),
            ),
            icon: Icon(
              Icons.lock_open,
              size: 30,
            ),
            label: Text(
              'Sign In',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signInHandler,
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Please enter a password';
        } else if (val.length < 6) {
          return 'Password must be at least 6 characters';
        }
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
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
