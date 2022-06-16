import 'package:flutter/material.dart';
import 'package:shop_app/components/custom_surfix_icon.dart';
import 'package:shop_app/components/default_button.dart';
import 'package:shop_app/screens/profile/profile_screen.dart';

import '../../../size_config.dart';

class CompletePaymentForm extends StatefulWidget {
  @override
  _CompletePaymentFormState createState() => _CompletePaymentFormState();
}

class _CompletePaymentFormState extends State<CompletePaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String?> errors = [];
  String? CardNum;
  String? Cvc;
  String? Exp;
  String? CardOwner;

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
          buildCardNumFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCvcFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildExpFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildCardOwnerFormField(),
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

  TextFormField buildCardNumFormField() {
    return TextFormField(
      onSaved: (newValue) => CardNum = newValue,
      decoration: InputDecoration(
        labelText: "Card Number",
        hintText: "Enter your card number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Cash.svg"),
      ),
    );
  }

  TextFormField buildCvcFormField() {
    return TextFormField(
      onSaved: (newValue) => Cvc = newValue,
      decoration: InputDecoration(
        labelText: "Cvc",
        hintText: "Enter your card cvc",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Cash.svg"),
      ),
    );
  }

  TextFormField buildExpFormField() {
    return TextFormField(
      onSaved: (newValue) => Exp = newValue,
      decoration: InputDecoration(
        labelText: "Exp",
        hintText: "Enter your card exp",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Cash.svg"),
      ),
    );
  }

  TextFormField buildCardOwnerFormField() {
    return TextFormField(
      onSaved: (newValue) => CardOwner = newValue,
      decoration: InputDecoration(
        labelText: "Card Owner",
        hintText: "Enter your card owner name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Cash.svg"),
      ),
    );
  }
}
