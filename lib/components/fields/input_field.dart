import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool isPassword;
  final bool readOnly;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Color? backgroundColor;
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
    this.backgroundColor,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final fieldBackgroundColor = backgroundColor ?? 
        (isDark ? Colors.grey.shade800 : Colors.grey.shade200);
    final textColor = isDark ? Colors.white : Colors.black;
    final hintColor = isDark ? Colors.grey.shade400 : Colors.black54;
    final borderColor = isDark ? Colors.grey.shade700 : Colors.black26;
    final focusedBorderColor = isDark ? Colors.white : Colors.black;
    
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onTap: readOnly && onTap != null ? onTap : null,
      enabled: true,
      obscureText: isPassword,
      keyboardType: keyboardType,
      style: TextStyle(fontSize: 16, color: textColor),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: hintColor, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        filled: true,
        fillColor: fieldBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: focusedBorderColor),
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
