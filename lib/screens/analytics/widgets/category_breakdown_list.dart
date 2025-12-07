import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/spending_calculator.dart';
import 'package:fintrack_app/utils/currency.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Expenses Breakdown",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
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

