import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/screens/analytics/widgets/time_period_selector.dart';

class AnalyticsCalculator {
  static Map<String, double> calculatePeriodTotals(
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

    final filteredTransactions = transactions.where((transaction) {
      return transaction.date.isAfter(
            startDate.subtract(const Duration(days: 1)),
          ) &&
          transaction.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();

    double income = 0;
    double expense = 0;

    for (var transaction in filteredTransactions) {
      if (transaction.isIncome) {
        income += transaction.amount;
      } else {
        expense += transaction.amount;
      }
    }

    return {'income': income, 'expense': expense, 'total': income - expense};
  }
}
