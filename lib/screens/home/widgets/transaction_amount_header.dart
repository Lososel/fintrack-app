import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/currency.dart';

class TransactionAmountHeader extends StatelessWidget {
  final double amount;
  final bool isExpense;
  final Currency currency;

  const TransactionAmountHeader({
    super.key,
    required this.amount,
    required this.isExpense,
    this.currency = Currency.dollar,
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
            color: isExpense ? Colors.red.shade700 : Colors.green.shade700,
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
                CurrencyHelper.formatAmountWithSign(
                  amount,
                  currency,
                  !isExpense,
                ),
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
