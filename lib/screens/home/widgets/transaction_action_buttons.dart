import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/button/secondary_button.dart';

class TransactionActionButtons extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TransactionActionButtons({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(label: "Edit", onPressed: onEdit),
        const SizedBox(height: 16),
        SecondaryButton(label: "Delete", onPressed: onDelete),
      ],
    );
  }
}
