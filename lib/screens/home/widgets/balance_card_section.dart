import 'package:flutter/material.dart';
import 'package:fintrack_app/components/cards/balance_card.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/services/currency_conversion_service.dart';

class BalanceCardSection extends StatelessWidget {
  final List<TransactionModel> transactions;

  const BalanceCardSection({super.key, required this.transactions});

  Future<Map<String, double>> _calculateTotals() async {
    final conversionService = CurrencyConversionService();
    double income = 0;
    double expense = 0;

    for (var transaction in transactions) {
      final convertedAmount = await conversionService.convertToBase(
        transaction.amount,
        transaction.currency,
      );
      if (transaction.isIncome) {
        income += convertedAmount;
      } else {
        expense += convertedAmount;
      }
    }

    return {'income': income, 'expense': expense, 'total': income - expense};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, double>>(
      future: _calculateTotals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final totals = snapshot.data ?? {'income': 0.0, 'expense': 0.0, 'total': 0.0};
        return BalanceCard(
          totalBalance: totals['total']!,
          income: totals['income']!,
          expense: totals['expense']!,
        );
      },
    );
  }
}
