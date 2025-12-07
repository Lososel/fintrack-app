import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/components/cards/balance_card.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/utils/analytics_calculator.dart';
import 'widgets/spending_overview.dart';
import 'widgets/time_period_selector.dart';
import 'widgets/income_expense_trend_chart.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final TransactionService _transactionService = TransactionService();
  TimePeriod _selectedPeriod = TimePeriod.month;

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
    final totals = AnalyticsCalculator.calculatePeriodTotals(
      _transactionService.transactions,
      _selectedPeriod,
    );

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F9),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                "Analytics",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 4),
              const Text(
                "Track your financial insights",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              TimePeriodSelector(
                selectedPeriod: _selectedPeriod,
                onPeriodChanged: (period) {
                  setState(() {
                    _selectedPeriod = period;
                  });
                },
              ),
              const SizedBox(height: 20),
              BalanceCard(
                totalBalance: totals['total']!,
                income: totals['income']!,
                expense: totals['expense']!,
                title: "Total Savings",
                showSavingsPercentage: true,
              ),
              const SizedBox(height: 30),
              
              IncomeExpenseTrendChart(
                transactions: _transactionService.transactions,
                selectedPeriod: _selectedPeriod,
              ),
              const SizedBox(height: 30),
              SpendingOverview(selectedPeriod: _selectedPeriod),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

