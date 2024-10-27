import 'package:flutter/material.dart';
import 'package:tiktok_flutter/constants.dart';

class MainTextField extends StatelessWidget {
  final TextEditingController controller;
  final String lable;
  final bool isObscure;
  final Icon icon;
  const MainTextField({
    super.key,
    required this.controller,
    required this.lable,
    required this.icon,
    this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: icon,
        labelText: lable,
        focusColor: Colors.blue,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: borderColor,
          ),
        ),
      ),
      obscureText: isObscure,
    );
  }
}
