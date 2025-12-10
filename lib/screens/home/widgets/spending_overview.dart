import 'package:flutter/material.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/utils/spending_calculator.dart';
import 'package:fintrack_app/utils/category_colors.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/utils/app_localizations.dart';
import 'package:fintrack_app/components/charts/spending_pie_chart.dart';
import '../../analytics/analytics_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.grey.shade400 : Colors.black54;

    return FutureBuilder<List<CategorySpending>>(
      future: SpendingCalculator.calculateSpendingByCategory(
        _transactionService.transactions,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final spendingByCategory = snapshot.data ?? [];

        if (spendingByCategory.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localizations.spendingOverview,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.noExpensesYet,
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localizations.spendingOverview,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: textColor,
                  ),
                ),

                GestureDetector(
                  onTap: () {
                    // Navigate to analytics screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AnalyticsScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "${localizations.viewDetails} →",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Center(
              child: Column(
                children: [
                  // Pie Chart
                  SpendingPieChart(
                    spendingByCategory: spendingByCategory,
                    currency: Currency.dollar, // Always use dollar after conversion
                    size: 180,
                    centerSpaceRadius: 50,
                    baseRadius: 60,
                    touchedRadius: 65,
                  ),
                  const SizedBox(height: 20),
                  // Legend
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _buildLegend(spendingByCategory),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Currency _getCurrency() {
    final transactions = _transactionService.transactions;
    if (transactions.isEmpty) {
      return Currency.dollar;
    }
    // Get currency from first expense transaction, or default to dollar
    final expense = transactions.firstWhere(
      (t) => !t.isIncome,
      orElse: () => transactions.first,
    );
    return expense.currency;
  }

  List<Widget> _buildLegend(List<CategorySpending> spendingByCategory) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    
    return spendingByCategory.map((categorySpending) {
      final color = CategoryColors.getColor(categorySpending.category);
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                categorySpending.category,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
