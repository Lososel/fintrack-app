import 'package:flutter/material.dart';
import 'package:fintrack_app/components/cards/balance_card.dart';

class BalanceCardSection extends StatelessWidget {
  const BalanceCardSection({super.key});

  @override
  Widget build(BuildContext context) {
    // For now, static mock numbers.
    // Later you can replace with real API / database values.
    final income = 4000.00;
    final expense = 575.49;
    final total = income - expense;

    return BalanceCard(totalBalance: total, income: income, expense: expense);
  }
}
