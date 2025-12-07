import 'package:flutter/material.dart';
import 'package:fintrack_app/models/transaction_model.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: transaction.isIncome
                  ? const Color(0xffDBF4F0)
                  : const Color(0xffFDE7E7),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.monetization_on,
              size: 22,
              color: transaction.isIncome
                  ? Colors.green.shade700
                  : Colors.red.shade700,
            ),
          ),

          const SizedBox(width: 16),

          // Title + Category
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                  ),
                ),

                Text(
                  transaction.category,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),

          // Amount + Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${transaction.isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: transaction.isIncome ? Colors.green : Colors.red,
                ),
              ),

              Text(
                transaction.date.toIso8601String().split("T")[0],
                style: const TextStyle(fontSize: 13, color: Colors.black45),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
