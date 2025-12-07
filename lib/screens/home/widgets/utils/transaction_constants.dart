import 'package:flutter/material.dart';

class TransactionConstants {
  static const List<String> paymentMethods = [
    "Cash",
    "Credit Card",
    "Debit Card",
    "Bank Transfer",
    "Mobile Wallet",
    "Other",
  ];

  static const List<String> categories = [
    "Travel",
    "Dining",
    "Groceries",
    "Utilities",
    "Shopping",
    "Entertainment",
    "Health",
    "Salary",
    "Other",
  ];

  static const Map<String, IconData> categoryIcons = {
    "Travel": Icons.flight_takeoff,
    "Dining": Icons.restaurant,
    "Groceries": Icons.local_grocery_store,
    "Utilities": Icons.lightbulb_outline,
    "Shopping": Icons.shopping_bag,
    "Entertainment": Icons.movie,
    "Health": Icons.favorite_outline,
    "Salary": Icons.attach_money,
    "Other": Icons.more_horiz,
  };
}

