import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:voucher_giga/My_Widgets/my_button.dart';
import 'package:voucher_giga/View/Home_Screen/home_screen.dart';
import 'package:voucher_giga/View_Model/auth_provider.dart';

class LoginForm extends StatefulWidget {
  LoginForm({
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authProvider = AuthProvider();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            onChanged: (value) => authProvider.email = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.white.withOpacity(0.5),
              label: Text('Email'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.02),
          TextFormField(
            onChanged: (value) => authProvider.password = value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
            keyboardType: TextInputType.text,
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              filled: true,
              fillColor: Colors.white.withOpacity(0.5),
              label: Text('Password'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.04),
          context.watch<AuthProvider>().isloading
              ? CircularProgressIndicator()
              : CustomButton(
                  text: 'Login',
                  onPressed: () async {
                    await context.read<AuthProvider>().loginFuction(
                          _emailController.text,
                          _passwordController.text,
                        );
                    await Future.delayed(const Duration(seconds: 3));
                    // Get.to(() => HomeScreen());
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                ),
        ],
      ),
    );
  }
}
