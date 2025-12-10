import 'package:flutter/material.dart';
import 'package:fintrack_app/models/budget_model.dart';
import 'package:fintrack_app/utils/currency.dart';

class TotalBudgetCard extends StatelessWidget {
  final double totalSpending;
  final TotalBudgetModel? totalBudget;
  final Currency currency;

  const TotalBudgetCard({
    super.key,
    required this.totalSpending,
    this.totalBudget,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? Colors.grey.shade800 : Colors.grey.shade900;
    final budgetLimit = totalBudget?.limit ?? 0.0;
    final percentage = budgetLimit > 0 ? (totalSpending / budgetLimit) * 100 : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Total Budget",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "${currency.symbol}${totalSpending.toStringAsFixed(2)}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (budgetLimit > 0) ...[
            const SizedBox(height: 4),
            Text(
              "of ${currency.symbol}${budgetLimit.toStringAsFixed(2)}",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
          if (budgetLimit > 0) ...[
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${percentage.toStringAsFixed(0)}% Used",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

