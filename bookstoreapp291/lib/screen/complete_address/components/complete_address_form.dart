import 'package:flutter/material.dart';
import 'package:bookstoreapp291/components/custom_surfix_icon.dart';
import 'package:bookstoreapp291/components/default_button.dart';
import 'package:bookstoreapp291/screen/otp_phone/otp_screen.dart';
import 'package:bookstoreapp291/screen/profile/profile_screen.dart';

import '../../../size_config.dart';

class CompleteAddressForm extends StatefulWidget {
  @override
  _CompleteAddressFormState createState() => _CompleteAddressFormState();
}

class _CompleteAddressFormState extends State<CompleteAddressForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? Address;
  String? PostalCode;

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
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPostalCodeFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "SAVE",
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

  TextFormField buildAddressFormField() {
    return TextFormField(
      onSaved: (newValue) => Address = newValue,
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your Address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location Point.svg"),
      ),
    );
  }

  TextFormField buildPostalCodeFormField() {
    return TextFormField(
      onSaved: (newValue) => PostalCode = newValue,
      decoration: InputDecoration(
        labelText: "PostalCode",
        hintText: "Enter Postal Code",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location Point.svg"),
      ),
    );
  }
}
