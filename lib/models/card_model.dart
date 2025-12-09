class CardModel {
  final String id;
  final String cardName;
  final String bankName;
  final String cardNumber;
  final String category;
  final double balance;
  final String assetPath;
  final String accountType; // Debit, Credit, Savings, Checking

  CardModel({
    required this.id,
    required this.cardName,
    required this.bankName,
    required this.cardNumber,
    required this.category,
    required this.balance,
    required this.assetPath,
    required this.accountType,
  });
}
