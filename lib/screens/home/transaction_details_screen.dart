import 'package:flutter/material.dart';
import 'package:fintrack_app/components/arrow/back_arrow.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'widgets/transaction_amount_header.dart';
import 'widgets/transaction_details_card.dart';
import 'widgets/transaction_action_buttons.dart';

class TransactionDetailsScreen extends StatelessWidget {
  final String category;
  final double amount;
  final DateTime date;
  final bool isExpense;
  final String paymentMethod;
  final String description;
  final Currency currency;

  const TransactionDetailsScreen({
    super.key,
    required this.category,
    required this.amount,
    required this.date,
    required this.isExpense,
    required this.paymentMethod,
    required this.description,
    this.currency = Currency.dollar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F7),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackArrow(),
                    const SizedBox(height: 10),
                    const Text(
                      "Transaction Details",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TransactionAmountHeader(
                      amount: amount,
                      isExpense: isExpense,
                      currency: currency,
                    ),
                    const SizedBox(height: 30),
                    TransactionDetailsCard(
                      category: category,
                      date: date,
                      paymentMethod: paymentMethod,
                      description: description,
                    ),
                    const SizedBox(height: 30),
                    TransactionActionButtons(
                      onEdit: () {
                        // TODO: Navigate to edit screen
                        Navigator.pop(context);
                      },
                      onDelete: () {
                        // TODO: Show delete confirmation
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Bottom Navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: const HomeBottomNav(),
            ),
          ],
        ),
      ),
    );
  }
}
