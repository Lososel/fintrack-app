import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/spending_calculator.dart';
import 'package:fintrack_app/utils/category_colors.dart';
import 'package:fintrack_app/utils/currency.dart';
import '../../home/widgets/utils/transaction_icons.dart';

class CategoryItem extends StatelessWidget {
  final CategorySpending categorySpending;
  final Currency currency;
  final double totalSpending;

  const CategoryItem({
    super.key,
    required this.categorySpending,
    required this.currency,
    required this.totalSpending,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final color = CategoryColors.getColor(categorySpending.category);
    final icon = TransactionIcons.getCategoryIcon(categorySpending.category);
    final percentage = (categorySpending.amount / totalSpending) * 100;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF181820) : Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categorySpending.category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${percentage.toStringAsFixed(1)}% of total",
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? Colors.grey.shade400 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyHelper.formatAmount(categorySpending.amount, currency),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade800 : Colors.grey[200],
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percentage / 100,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
