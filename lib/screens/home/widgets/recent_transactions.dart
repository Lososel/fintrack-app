import 'package:flutter/material.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/components/transaction/transaction_item.dart';

class RecentTransactions extends StatelessWidget {
  final List<TransactionModel> transactions;

  const RecentTransactions({
    super.key,
    required this.transactions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Recent Transactions",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        if (transactions.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "No transactions yet",
              style: TextStyle(color: Colors.black54),
            ),
          )
        else
          for (var tx in transactions) TransactionItem(transaction: tx),
      ],
    );
  }
}
