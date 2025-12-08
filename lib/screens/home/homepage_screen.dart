import 'package:flutter/material.dart';
import 'package:fintrack_app/screens/home/widgets/home_header.dart';
import 'package:fintrack_app/screens/home/widgets/home_actions.dart';
import 'package:fintrack_app/screens/home/widgets/spending_overview.dart';
import 'package:fintrack_app/screens/home/widgets/monthly_comparison.dart';
import 'package:fintrack_app/screens/home/widgets/balance_card_section.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/screens/home/widgets/recent_transactions.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/services/user_service.dart';

class HomeScreen extends StatefulWidget {
  final String? name;

  const HomeScreen({super.key, this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TransactionService _transactionService = TransactionService();
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _transactionService.addListener(_refreshTransactions);
    _userService.addListener(_refreshTransactions);
  }

  @override
  void dispose() {
    _transactionService.removeListener(_refreshTransactions);
    _userService.removeListener(_refreshTransactions);
    super.dispose();
  }

  void _refreshTransactions() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final recentTransactions = _transactionService.recentTransactions;
    final allTransactions = _transactionService.transactions;

    final userName = _userService.name ?? widget.name ?? "User";

    return Scaffold(
      backgroundColor: const Color(0xfFF6F6F9),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              HomeHeader(),

              const SizedBox(height: 16),
              BalanceCardSection(transactions: allTransactions),

              const SizedBox(height: 20),
              const HomeActions(),

              const SizedBox(height: 30),
              SpendingOverview(),

              const SizedBox(height: 30),
              MonthlyComparison(),

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
