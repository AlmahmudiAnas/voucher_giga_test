import 'package:flutter/material.dart';
import 'package:voucher_giga/View_Model/auth_provider.dart';

class MyField extends StatelessWidget {
  const MyField({
    super.key,
    required this.authProvider,
    required this.controller,
    required this.text,
    required this.onChanged,
  });

  final AuthProvider authProvider;
  final TextEditingController controller;
  final String text;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Field cannot be empty';
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.white.withOpacity(0.5),
        label: Text(text),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
