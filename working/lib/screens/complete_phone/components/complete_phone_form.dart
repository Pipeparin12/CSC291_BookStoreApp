import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

import '../../../size_config.dart';

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
                Navigator.pushNamed(context, ProfileScreen.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPhoneNumFormField() {
    return TextFormField(
      onSaved: (newValue) => PhoneNum = newValue,
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
      onSaved: (newValue) => ReEnterPhoneNum = newValue,
      decoration: InputDecoration(
        labelText: "ReEnterPhoneNum",
        hintText: "Enter your Phone Number Agian",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }
}
