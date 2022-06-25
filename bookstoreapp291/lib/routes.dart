import 'dart:js';

import 'package:flutter/widgets.dart';
import 'package:shop_app/screen/Chechout/checkout_screen.dart';
import 'package:shop_app/screen/cart/cart_screen.dart';
import 'package:shop_app/screen/complete_address/complete_address_screen.dart';
import 'package:shop_app/screen/complete_email/complete_email_screen.dart';
import 'package:shop_app/screen/complete_payment/complete_payment_screen.dart';
import 'package:shop_app/screen/complete_phone/complete_phone_screen.dart';
import 'package:shop_app/screen/complete_profile/complete_profile_screen.dart';
import 'package:shop_app/screen/forgot_password/forgot_password_screen.dart';
import 'package:shop_app/screen/login_success/login_success_screen.dart';
import 'package:shop_app/screen/otp/otp_screen.dart';
import 'package:shop_app/screen/otp_phone/otp_screen.dart';
import 'package:shop_app/screen/profile/profile_screen.dart';
import 'package:shop_app/screen/sign_in/sign_in_screen.dart';
import 'package:shop_app/screen/splash/splash_screen.dart';

import 'screen/sign_up/sign_up_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  OtpPhoneScreen.routeName: (context) => OtpPhoneScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  CompletePaymentScreen.routeName: (context) => CompletePaymentScreen(),
  CompleteEmailScreen.routeName: (context) => CompleteEmailScreen(),
  CompletePhoneScreen.routeName: (context) => CompletePhoneScreen(),
  CompleteAddressScreen.routeName: (context) => CompleteAddressScreen(),
  CheckoutScreen.routeName: (context) => CheckoutScreen(),
};
