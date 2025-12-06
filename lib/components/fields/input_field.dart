import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final double verticalPadding;
  final double horizontalPadding;
  final TextEditingController? controller;

  const InputField({
    required this.hint,
    this.isPassword = false,
    this.verticalPadding = 23,
    this.horizontalPadding = 23,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black26),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black26),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
