import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onAddTransaction;
  final VoidCallback onViewAll;

  const ActionButtons({
    super.key,
    required this.onAddTransaction,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onAddTransaction,
            icon: const Icon(Icons.add, color: Colors.white, size: 13),
            label: Text(
              localizations.addTransaction,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff1e1e1e),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: OutlinedButton(
            onPressed: onViewAll,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              side: const BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              localizations.viewAll,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
