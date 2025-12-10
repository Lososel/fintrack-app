import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class BalanceCard extends StatelessWidget {
  final double totalBalance;
  final double income;
  final double expense;
  final String? title;
  final bool showSavingsPercentage;

  const BalanceCard({
    super.key,
    required this.totalBalance,
    required this.income,
    required this.expense,
    this.title,
    this.showSavingsPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final displayTitle = title ?? localizations.totalBalance;
    final savingsPercentage = income > 0 ? (totalBalance / income) * 100 : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF181820) : const Color(0xff1e1e1e),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "\$${totalBalance.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (showSavingsPercentage && income > 0) ...[
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: savingsPercentage / 100,
                      minHeight: 8,
                      backgroundColor: Colors.white.withOpacity(0.2),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "${savingsPercentage.toStringAsFixed(1)}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              _info(localizations.income, income),
              const SizedBox(width: 50),
              _info(localizations.expense, expense),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(String label, double value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),

        Text(
          "\$${value.toStringAsFixed(2)}",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
