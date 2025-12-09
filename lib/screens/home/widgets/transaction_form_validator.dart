import 'package:flutter/material.dart';

class TransactionFormValidator {
  static String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Please enter an amount";
    }

    final amount = double.tryParse(value.trim());
    if (amount == null || amount <= 0) {
      return "Please enter a valid amount";
    }

    return null;
  }

  static String? validateCategory(String? value) {
    if (value == null || value.isEmpty) {
      return "Please select a category";
    }
    return null;
  }

  static void showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}

