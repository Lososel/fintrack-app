import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnly;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  InputField({
    super.key,
    required this.hint,
    this.controller,
    this.isPassword = false,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
    this.backgroundColor = Colors.white,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        filled: true,
        fillColor: backgroundColor,
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
        suffixIcon: suffixIcon,
        errorText:
            validator != null &&
                controller != null &&
                controller!.text.isNotEmpty
            ? validator!(controller!.text)
            : null,
      ),
    );
  }
}
