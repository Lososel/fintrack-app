import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/services/currency_conversion_service.dart';

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
  static Future<List<CategorySpending>> calculateSpendingByCategory(
    List<TransactionModel> transactions,
  ) async {
    // Filter only expenses (not income)
    final expenses = transactions.where((t) => !t.isIncome).toList();

    if (expenses.isEmpty) {
      return [];
    }

    final conversionService = CurrencyConversionService();
    
    // Calculate total spending with currency conversion
    double totalSpending = 0.0;
    for (var transaction in expenses) {
      final convertedAmount = await conversionService.convertToBase(
        transaction.amount,
        transaction.currency,
      );
      totalSpending += convertedAmount;
    }

    if (totalSpending == 0) {
      return [];
    }

    // Group by category and sum amounts (converted to base currency)
    final Map<String, double> categoryTotals = {};
    for (var transaction in expenses) {
      final convertedAmount = await conversionService.convertToBase(
        transaction.amount,
        transaction.currency,
      );
      categoryTotals[transaction.category] =
          (categoryTotals[transaction.category] ?? 0) + convertedAmount;
    }

    // Convert to list and calculate percentages
    final List<CategorySpending> spendingByCategory = categoryTotals.entries
        .map(
          (entry) => CategorySpending(
            category: entry.key,
            amount: entry.value,
            percentage: (entry.value / totalSpending) * 100,
          ),
        )
        .toList();

    // Sort by amount descending
    spendingByCategory.sort((a, b) => b.amount.compareTo(a.amount));

    return spendingByCategory;
  }
}
