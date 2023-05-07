import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:voucher_giga/View_Model/voucher_provider.dart';
import 'Components/login_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = 'Login Screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 92, 152, 255),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.25),
              Image.asset(
                "images/logo-giga.png",
                scale: 2,
              ),
              // Text(
              //   'Login',
              //   style: TextStyle(
              //     fontFamily: 'Cursive',
              //     fontSize: 50,
              //     fontWeight: FontWeight.bold,
              //     color: Colors.white,
              //   ),
              // ),
              SizedBox(height: size.height * 0.05),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
