import 'package:flutter/material.dart';
import 'package:fintrack_app/components/cards/balance_card.dart';
import 'package:fintrack_app/models/transaction_model.dart';

class BalanceCardSection extends StatelessWidget {
  final List<TransactionModel> transactions;

  const BalanceCardSection({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    double income = 0;
    double expense = 0;

    for (var transaction in transactions) {
      if (transaction.isIncome) {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    final total = income - expense;

    return BalanceCard(totalBalance: total, income: income, expense: expense);
  }
}
