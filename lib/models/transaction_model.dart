class TransactionModel {
  final String title;
  final String category;
  final double amount;
  final DateTime date;
  final bool isIncome;

  TransactionModel({
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
    required this.isIncome,
  });
}
