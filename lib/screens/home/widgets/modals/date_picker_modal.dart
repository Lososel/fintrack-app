import 'package:flutter/material.dart';
import 'package:fintrack_app/components/modal/app_modal.dart';

class DatePickerModal extends StatelessWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final Function(DateTime) onDateSelected;

  const DatePickerModal({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppModal(
      title: "Select Date",
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: CalendarDatePicker(
          initialDate: initialDate,
          firstDate: firstDate,
          lastDate: lastDate,
          onDateChanged: (date) {
            onDateSelected(date);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

