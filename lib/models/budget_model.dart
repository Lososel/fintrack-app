import 'package:fintrack_app/utils/currency.dart';

class BudgetModel {
  final String category;
  final double limit;
  final Currency currency;
  final String period; // "Monthly", "Weekly", etc.

  BudgetModel({
    required this.category,
    required this.limit,
    this.currency = Currency.dollar,
    this.period = "Monthly",
  });
}

class TotalBudgetModel {
  final double limit;
  final Currency currency;
  final String period;

  TotalBudgetModel({
    required this.limit,
    this.currency = Currency.dollar,
    this.period = "Monthly",
  });
}

