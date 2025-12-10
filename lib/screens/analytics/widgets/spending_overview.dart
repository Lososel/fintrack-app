import 'package:flutter/material.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/utils/spending_calculator.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/utils/app_localizations.dart';
import 'package:fintrack_app/components/charts/spending_pie_chart.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'spending_empty_state.dart';
import 'category_breakdown_list.dart';
import 'time_period_selector.dart';

class SpendingOverview extends StatefulWidget {
  final TimePeriod selectedPeriod;

  const SpendingOverview({super.key, required this.selectedPeriod});

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

  List<TransactionModel> _filterTransactionsByPeriod(
    List<TransactionModel> transactions,
    TimePeriod period,
  ) {
    final now = DateTime.now();
    DateTime startDate;

    switch (period) {
      case TimePeriod.day:
        startDate = DateTime(now.year, now.month, now.day);
        break;
      case TimePeriod.week:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        break;
      case TimePeriod.month:
        // Rolling 30 days including today (from 29 days ago to today)
        startDate = now.subtract(const Duration(days: 29));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        break;
      case TimePeriod.year:
        startDate = DateTime(now.year, 1, 1);
        break;
    }

    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return transactions.where((transaction) {
      return transaction.date.isAfter(
            startDate.subtract(const Duration(days: 1)),
          ) &&
          transaction.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();
  }

  Currency _getCurrency(List<TransactionModel> transactions) {
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
    final allTransactions = _transactionService.transactions;
    final filteredTransactions = _filterTransactionsByPeriod(
      allTransactions,
      widget.selectedPeriod,
    );

    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

    return FutureBuilder<List<CategorySpending>>(
      future: SpendingCalculator.calculateSpendingByCategory(
        filteredTransactions,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final spendingByCategory = snapshot.data ?? [];

        if (spendingByCategory.isEmpty) {
          return const SpendingEmptyState();
        }

        final totalSpending = spendingByCategory.fold<double>(
          0.0,
          (sum, item) => sum + item.amount,
        );

        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.spendingOverview,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: SpendingPieChart(
                spendingByCategory: spendingByCategory,
                currency: Currency.dollar, // Always use dollar after conversion
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
              currency: Currency.dollar, // Always use dollar after conversion
              totalSpending: totalSpending,
            ),
          ],
        );
      },
    );
  }
}
