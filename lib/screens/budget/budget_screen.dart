import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/services/budget_service.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/screens/budget/widgets/total_budget_card.dart';
import 'package:fintrack_app/screens/budget/widgets/swipeable_category_budget_item.dart';
import 'package:fintrack_app/screens/budget/widgets/create_budget_modal.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  final BudgetService _budgetService = BudgetService();
  final TransactionService _transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
    _budgetService.addListener(_refresh);
    _transactionService.addListener(_refresh);
  }

  @override
  void dispose() {
    _budgetService.removeListener(_refresh);
    _transactionService.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  double _calculateCategorySpending(String category) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    return _transactionService.transactions
        .where((t) =>
            !t.isIncome &&
            t.category == category &&
            t.date.isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
            t.date.isBefore(endOfMonth.add(const Duration(days: 1))))
        .fold<double>(0.0, (sum, t) => sum + t.amount);
  }

  double _calculateTotalSpending() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);

    return _transactionService.transactions
        .where((t) =>
            !t.isIncome &&
            t.date.isAfter(startOfMonth.subtract(const Duration(days: 1))) &&
            t.date.isBefore(endOfMonth.add(const Duration(days: 1))))
        .fold<double>(0.0, (sum, t) => sum + t.amount);
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

  void _openCreateBudgetModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateBudgetModal(
        onBudgetCreated: () {
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.grey.shade400 : Colors.black54;
    final currency = _getCurrency();
    final totalSpending = _calculateTotalSpending();
    final totalBudget = _budgetService.totalBudget;
    final categoryBudgets = _budgetService.categoryBudgets;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: const HomeBottomNav(currentIndex: 2),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                "Budgets",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => CreateBudgetModal(
                      isTotalBudget: true,
                      existingTotalBudget: totalBudget,
                      onBudgetCreated: () {
                        setState(() {});
                      },
                    ),
                  );
                },
                child: TotalBudgetCard(
                  totalSpending: totalSpending,
                  totalBudget: totalBudget,
                  currency: currency,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                "Category Budgets",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 16),
              if (categoryBudgets.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "No category budgets set yet",
                    style: TextStyle(
                      fontSize: 14,
                      color: secondaryTextColor,
                    ),
                  ),
                )
              else
                ...categoryBudgets.map((budget) {
                  final spending = _calculateCategorySpending(budget.category);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SwipeableCategoryBudgetItem(
                      budget: budget,
                      spending: spending,
                      currency: currency,
                      onBudgetChanged: _refresh,
                    ),
                  );
                }),
              const SizedBox(height: 20),
              PrimaryButton(
                label: "Create Budget",
                onPressed: _openCreateBudgetModal,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

