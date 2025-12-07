import 'package:flutter/material.dart';
import 'package:fintrack_app/components/fields/input_field.dart';

class DatePickerField extends StatelessWidget {
  final DateTime date;
  final VoidCallback onTap;

  const DatePickerField({super.key, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        "${date.day.toString().padLeft(2, '0')}."
        "${date.month.toString().padLeft(2, '0')}."
        "${date.year}";

    return InputField(
      hint: formattedDate,
      readOnly: true,
      onTap: onTap,
      suffixIcon: const Icon(Icons.calendar_today, size: 20),
    );
  }
}
