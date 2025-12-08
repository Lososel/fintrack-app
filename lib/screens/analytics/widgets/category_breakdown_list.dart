import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/spending_calculator.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/utils/app_localizations.dart';
import 'category_item.dart';

class CategoryBreakdownList extends StatelessWidget {
  final List<CategorySpending> spendingByCategory;
  final Currency currency;
  final double totalSpending;

  const CategoryBreakdownList({
    super.key,
    required this.spendingByCategory,
    required this.currency,
    required this.totalSpending,
  });

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.expensesBreakdown,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 16),
        ...spendingByCategory.map((categorySpending) {
          return CategoryItem(
            categorySpending: categorySpending,
            currency: currency,
            totalSpending: totalSpending,
          );
        }),
      ],
    );
  }
}
