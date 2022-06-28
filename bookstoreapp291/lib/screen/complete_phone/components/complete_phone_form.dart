import 'package:bookstoreapp291/constants.dart';
import 'package:flutter/material.dart';
import 'package:bookstoreapp291/components/custom_surfix_icon.dart';
import 'package:bookstoreapp291/components/default_button.dart';
import 'package:bookstoreapp291/screen/otp_phone/otp_screen.dart';
import 'package:bookstoreapp291/screen/profile/profile_screen.dart';

import '../../../sizedConfig.dart';

class CompletePhoneForm extends StatefulWidget {
  @override
  _CompletePhoneFormState createState() => _CompletePhoneFormState();
}

class _CompletePhoneFormState extends State<CompletePhoneForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? PhoneNum;
  String? ReEnterPhoneNum;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildPhoneNumFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildReEnterPhoneNumFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "CONTINUE",
            press: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OtpPhoneScreen()));
              }
            },
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => OtpPhoneScreen())),
          ),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => PhoneNum = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        PhoneNum = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "PhoneNumber",
        hintText: "Enter your Phone Number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  TextFormField buildReEnterPhoneNumFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => ReEnterPhoneNum = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && PhoneNum == ReEnterPhoneNum) {
          removeError(error: kMatchPassError);
        }
        ReEnterPhoneNum = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((PhoneNum != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "ReEnterPhoneNumber",
        hintText: "Comfirm Phone Number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }
}
