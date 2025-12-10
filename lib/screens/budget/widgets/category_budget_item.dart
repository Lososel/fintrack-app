import 'package:flutter/material.dart';
import 'package:fintrack_app/models/budget_model.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/utils/category_colors.dart';
import 'package:fintrack_app/screens/home/widgets/utils/transaction_icons.dart';

class CategoryBudgetItem extends StatelessWidget {
  final BudgetModel budget;
  final double spending;
  final Currency currency;
  final VoidCallback onTap;

  const CategoryBudgetItem({
    super.key,
    required this.budget,
    required this.spending,
    required this.currency,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardColor = isDark ? theme.cardColor : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.grey.shade400 : Colors.black54;
    final categoryColor = CategoryColors.getColor(budget.category);
    final icon = TransactionIcons.getCategoryIcon(budget.category);
    final percentage = budget.limit > 0 ? (spending / budget.limit) * 100 : 0.0;
    final remaining = budget.limit - spending;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: categoryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: categoryColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        budget.category,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        budget.period,
                        style: TextStyle(
                          fontSize: 12,
                          color: secondaryTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${currency.symbol}${budget.limit.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              "${currency.symbol}${spending.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: percentage > 100 ? 1.0 : percentage / 100,
                minHeight: 8,
                backgroundColor: isDark
                    ? Colors.grey.shade700
                    : Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  percentage > 100 ? Colors.red : Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${percentage.toStringAsFixed(0)}% used",
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryTextColor,
                  ),
                ),
                Text(
                  "${currency.symbol}${remaining.toStringAsFixed(2)} remaining",
                  style: TextStyle(
                    fontSize: 12,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

