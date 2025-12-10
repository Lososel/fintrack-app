import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/button/secondary_button.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

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
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    
    return Column(
      children: [
        PrimaryButton(label: localizations.edit, onPressed: onEdit),
        const SizedBox(height: 16),
        SecondaryButton(label: localizations.delete, onPressed: onDelete),
      ],
    );
  }
}
