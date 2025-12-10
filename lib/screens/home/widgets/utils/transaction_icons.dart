import 'package:flutter/material.dart';

class TransactionIcons {
  static IconData getPaymentMethodIcon(String method) {
    switch (method) {
      case "Cash":
        return Icons.payments_outlined;
      case "Credit Card":
        return Icons.credit_card;
      case "Debit Card":
        return Icons.credit_score_outlined;
      case "Bank Transfer":
        return Icons.account_balance;
      case "Mobile Wallet":
        return Icons.phone_iphone;
      default:
        return Icons.more_horiz;
    }
  }

  static IconData getCategoryIcon(String category) {
    switch (category) {
      case "Travel":
        return Icons.flight_takeoff;
      case "Dining":
        return Icons.restaurant;
      case "Groceries":
        return Icons.local_grocery_store;
      case "Utilities":
        return Icons.lightbulb_outline;
      case "Shopping":
        return Icons.shopping_bag;
      case "Entertainment":
        return Icons.movie;
      case "Health":
        return Icons.favorite_outline;
      case "Salary":
        return Icons.attach_money;
      default:
        return Icons.more_horiz;
    }
  }
}
