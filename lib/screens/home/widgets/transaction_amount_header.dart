import 'package:flutter/material.dart';

class TransactionAmountHeader extends StatelessWidget {
  final double amount;
  final bool isExpense;

  const TransactionAmountHeader({
    super.key,
    required this.amount,
    required this.isExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: isExpense
                ? const Color(0xffFDE7E7)
                : const Color(0xffDBF4F0),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.monetization_on,
            size: 30,
            color: isExpense
                ? Colors.red.shade700
                : Colors.green.shade700,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isExpense ? "Expense" : "Income",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
      
              Text(
                "${isExpense ? '-' : '+'}\$${amount.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  color: isExpense ? Color(0xffB52424) : Color(0xFF31A05F),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

