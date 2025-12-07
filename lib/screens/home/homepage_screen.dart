import 'package:flutter/material.dart';
import 'package:fintrack_app/components/cards/balance_card.dart';
import 'package:fintrack_app/screens/home/widgets/home_header.dart';
import 'package:fintrack_app/screens/home/widgets/home_actions.dart';
import 'package:fintrack_app/screens/home/widgets/spending_overview.dart';
import 'package:fintrack_app/screens/home/widgets/monthly_comparison.dart';
import 'package:fintrack_app/screens/home/widgets/balance_card_section.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/screens/home/widgets/recent_transactions.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  const HomeScreen({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfF6F6F9),
      bottomNavigationBar: const HomeBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              HomeHeader(name: name),

              const SizedBox(height: 16),
              const BalanceCardSection(),

              const SizedBox(height: 20),
              const HomeActions(),

              const SizedBox(height: 30),
              const SpendingOverview(),

              const SizedBox(height: 30),
              const MonthlyComparison(),

              const SizedBox(height: 30),
              const RecentTransactions(),

              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
