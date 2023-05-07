import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:voucher_giga/My_Widgets/my_button.dart';
import 'package:voucher_giga/My_Widgets/my_field.dart';
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
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          MyField(
            onChanged: (value) => authProvider.email = value,
            authProvider: authProvider,
            controller: _emailController,
            text: 'Email',
            isPassword: false,
          ),
          SizedBox(height: size.height * 0.02),
          MyField(
            authProvider: authProvider,
            controller: _passwordController,
            text: 'Password',
            isPassword: true,
            onChanged: (value) => authProvider.password = value,
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
                    await Future.delayed(const Duration(seconds: 1));
                    Navigator.pushNamed(context, HomeScreen.routeName);
                  },
                ),
        ],
      ),
    );
  }
}
