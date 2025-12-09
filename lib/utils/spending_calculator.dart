import 'package:fintrack_app/models/transaction_model.dart';

class CategorySpending {
  final String category;
  final double amount;
  final double percentage;

  CategorySpending({
    required this.category,
    required this.amount,
    required this.percentage,
  });
}

class SpendingCalculator {
  static List<CategorySpending> calculateSpendingByCategory(
    List<TransactionModel> transactions,
  ) {
    // Filter only expenses (not income)
    final expenses = transactions.where((t) => !t.isIncome).toList();

    if (expenses.isEmpty) {
      return [];
    }

    // Calculate total spending
    final totalSpending = expenses.fold<double>(
      0.0,
      (sum, transaction) => sum + transaction.amount,
    );

    if (totalSpending == 0) {
      return [];
    }

    // Group by category and sum amounts
    final Map<String, double> categoryTotals = {};
    for (var transaction in expenses) {
      categoryTotals[transaction.category] =
          (categoryTotals[transaction.category] ?? 0) + transaction.amount;
    }

    // Convert to list and calculate percentages
    final List<CategorySpending> spendingByCategory = categoryTotals.entries
        .map((entry) => CategorySpending(
              category: entry.key,
              amount: entry.value,
              percentage: (entry.value / totalSpending) * 100,
            ))
        .toList();

    // Sort by amount descending
    spendingByCategory.sort((a, b) => b.amount.compareTo(a.amount));

    return spendingByCategory;
  }
}

