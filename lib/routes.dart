import 'package:flutter/material.dart';
import 'package:voucher_giga/View/Home_Screen/home_screen.dart';
import 'package:voucher_giga/View/Login_Screen/login_screen.dart';
import 'package:voucher_giga/View/Voucher_Details/voucher_details.dart';
import 'package:voucher_giga/View/Voucher_Qyantity/voucher_qantity.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  VoucherDetails.routeName: (context) => VoucherDetails(),
  NewVoucherDetails.routeName: (context) => NewVoucherDetails(),
};
