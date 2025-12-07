import 'package:flutter/material.dart';
import 'package:fintrack_app/components/fields/input_field.dart';

class CategoryDropdown extends StatelessWidget {
  final String current;
  final VoidCallback onTap;

  const CategoryDropdown({
    super.key,
    required this.current,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InputField(
      hint: current,
      readOnly: true,
      onTap: onTap,
      suffixIcon: const Icon(Icons.keyboard_arrow_down),
    );
  }
}


