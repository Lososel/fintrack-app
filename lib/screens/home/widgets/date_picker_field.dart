import 'package:flutter/material.dart';
import 'package:fintrack_app/components/fields/input_field.dart';

class DatePickerField extends StatefulWidget {
  final DateTime date;
  final VoidCallback onTap;

  const DatePickerField({super.key, required this.date, required this.onTap});

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late TextEditingController _controller;

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}."
        "${date.month.toString().padLeft(2, '0')}."
        "${date.year}";
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: _formatDate(widget.date));
  }

  @override
  void didUpdateWidget(DatePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.date != widget.date) {
      _controller.text = _formatDate(widget.date);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final iconColor = isDark ? Colors.white : Colors.black;
    
    return InputField(
      hint: "",
      controller: _controller,
      readOnly: true,
      onTap: widget.onTap,
      suffixIcon: Icon(Icons.calendar_today, size: 20, color: iconColor),
    );
  }
}
