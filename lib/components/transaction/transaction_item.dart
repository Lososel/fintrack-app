import 'package:flutter/material.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/utils/currency.dart';

class TransactionItem extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.grey.shade400 : Colors.black54;
    
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 16),
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                ),

                Text(
                  transaction.category,
                  style: TextStyle(
                    fontSize: 13,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),

          // Amount + Date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyHelper.formatAmountWithSign(
                  transaction.amount,
                  transaction.currency,
                  transaction.isIncome,
                ),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: transaction.isIncome ? Colors.green : Colors.red,
                ),
              ),

              Text(
                transaction.date.toIso8601String().split("T")[0],
                style: TextStyle(
                  fontSize: 13,
                  color: secondaryTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
