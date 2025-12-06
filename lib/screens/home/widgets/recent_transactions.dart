import 'package:flutter/material.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/components/transaction/transaction_item.dart';

class RecentTransactions extends StatelessWidget {
  const RecentTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for now — replace with real data later
    final List<TransactionModel> transactions = [
      TransactionModel(
        title: "Lunch at restaurant",
        category: "Food & Dining",
        amount: 45.50,
        date: DateTime(2025, 12, 5),
        isIncome: false,
      ),
      TransactionModel(
        title: "Electricity Bill",
        category: "Utilities",
        amount: 120.00,
        date: DateTime(2025, 12, 4),
        isIncome: false,
      ),
      TransactionModel(
        title: "Monthly salary",
        category: "Salary",
        amount: 3500.00,
        date: DateTime(2025, 12, 1),
        isIncome: true,
      ),
      TransactionModel(
        title: "New shoes",
        category: "Shopping",
        amount: 89.99,
        date: DateTime(2025, 12, 3),
        isIncome: false,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Transactions",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),

        for (var tx in transactions) TransactionItem(transaction: tx),
      ],
    );
  }
}
