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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final borderColor = isDark ? Colors.white : Colors.black;
    final textColor = isDark ? Colors.white : Colors.black;

    final buttonBackgroundColor = isDark ? Colors.grey.shade800 : const Color(0xff1e1e1e);
    final buttonTextColor = Colors.white;
    
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onAddTransaction,
            icon: Icon(
              Icons.add,
              color: buttonTextColor,
              size: 13,
            ),
            label: Text(
              localizations.addTransaction,
              style: TextStyle(
                color: buttonTextColor,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonBackgroundColor,
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
              side: BorderSide(color: borderColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text(
              localizations.viewAll,
              style: TextStyle(
                color: textColor,
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
