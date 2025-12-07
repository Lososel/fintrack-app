import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/currency.dart';

class TotalSpendingCard extends StatelessWidget {
  final double totalSpending;
  final Currency currency;

  const TotalSpendingCard({
    super.key,
    required this.totalSpending,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text(
            "Total Savings",
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            CurrencyHelper.formatAmount(totalSpending, currency),
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}

