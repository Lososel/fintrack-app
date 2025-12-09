import 'package:flutter/material.dart';
import 'transaction_detail_row.dart';
import 'utils/transaction_icons.dart';
import 'utils/date_formatter.dart';

class TransactionDetailsCard extends StatelessWidget {
  final String category;
  final DateTime date;
  final String paymentMethod;
  final String description;

  const TransactionDetailsCard({
    super.key,
    required this.category,
    required this.date,
    required this.paymentMethod,
    required this.description,
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
          TransactionDetailRow(
            icon: Icons.grid_view,
            label: "Category",
            value: category,
            showValueIcon: true,
            valueIcon: TransactionIcons.getCategoryIcon(category),
          ),
          const SizedBox(height: 20),
          TransactionDetailRow(
            icon: Icons.calendar_today,
            label: "Date",
            value: DateFormatter.formatFullDate(date),
          ),
          const SizedBox(height: 20),
          TransactionDetailRow(
            icon: Icons.credit_card,
            label: "Payment Method",
            value: paymentMethod,
            showValueIcon: true,
            valueIcon: TransactionIcons.getPaymentMethodIcon(paymentMethod),
          ),
          const SizedBox(height: 20),
          TransactionDetailRow(
            icon: Icons.info_outline,
            label: "Description",
            value: description,
          ),
        ],
      ),
    );
  }
}

