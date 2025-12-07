import 'package:flutter/material.dart';
import 'package:fintrack_app/screens/home/widgets/home_header.dart';
import 'package:fintrack_app/screens/home/widgets/home_actions.dart';
import 'package:fintrack_app/screens/home/widgets/spending_overview.dart';
import 'package:fintrack_app/screens/home/widgets/monthly_comparison.dart';
import 'package:fintrack_app/screens/home/widgets/balance_card_section.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/screens/home/widgets/recent_transactions.dart';
import 'package:fintrack_app/services/transaction_service.dart';

class HomeScreen extends StatefulWidget {
  final String name;

  const HomeScreen({super.key, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TransactionService _transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
    _transactionService.addListener(_refreshTransactions);
  }

  @override
  void dispose() {
    _transactionService.removeListener(_refreshTransactions);
    super.dispose();
  }

  void _refreshTransactions() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final recentTransactions = _transactionService.recentTransactions;

    return Scaffold(
      backgroundColor: const Color(0xfFF6F6F9),
      bottomNavigationBar: HomeBottomNav(
        currentIndex: 0,
        userName: widget.name,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              HomeHeader(name: widget.name),

              const SizedBox(height: 16),
              const BalanceCardSection(),

              const SizedBox(height: 20),
              const HomeActions(),

              const SizedBox(height: 30),
              SpendingOverview(),

              const SizedBox(height: 30),
              const MonthlyComparison(),

              const SizedBox(height: 30),
              RecentTransactions(transactions: recentTransactions),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
