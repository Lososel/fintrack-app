import 'package:flutter/material.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/utils/spending_calculator.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/components/charts/spending_pie_chart.dart';
import 'spending_empty_state.dart';
import 'category_breakdown_list.dart';

class SpendingOverview extends StatefulWidget {
  const SpendingOverview({super.key});

  @override
  State<SpendingOverview> createState() => _SpendingOverviewState();
}

class _SpendingOverviewState extends State<SpendingOverview> {
  final TransactionService _transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
    _transactionService.addListener(_refresh);
  }

  @override
  void dispose() {
    _transactionService.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  Currency _getCurrency() {
    final transactions = _transactionService.transactions;
    if (transactions.isEmpty) {
      return Currency.dollar;
    }
    final expense = transactions.firstWhere(
      (t) => !t.isIncome,
      orElse: () => transactions.first,
    );
    return expense.currency;
  }

  @override
  Widget build(BuildContext context) {
    final spendingByCategory = SpendingCalculator.calculateSpendingByCategory(
      _transactionService.transactions,
    );

    if (spendingByCategory.isEmpty) {
      return const SpendingEmptyState();
    }

    final totalSpending = spendingByCategory.fold<double>(
      0.0,
      (sum, item) => sum + item.amount,
    );
    final currency = _getCurrency();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Spending Overview",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 30),
        Center(
          child: SpendingPieChart(
            spendingByCategory: spendingByCategory,
            currency: currency,
            totalSpending: totalSpending,
            size: 250,
            centerSpaceRadius: 70,
            baseRadius: 70,
            touchedRadius: 75,
            showCategoryDetails: true,
          ),
        ),
        const SizedBox(height: 30),
        CategoryBreakdownList(
          spendingByCategory: spendingByCategory,
          currency: currency,
          totalSpending: totalSpending,
        ),
      ],
    );
  }
}
