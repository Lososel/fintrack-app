import 'package:flutter/material.dart';
import 'package:fintrack_app/models/transaction_model.dart';

class TransactionService {
  static final TransactionService _instance = TransactionService._internal();
  factory TransactionService() => _instance;
  TransactionService._internal();

  final List<TransactionModel> _transactions = [];

  List<TransactionModel> get transactions => List.unmodifiable(_transactions);

  List<TransactionModel> get recentTransactions {
    final sorted = List<TransactionModel>.from(_transactions);
    sorted.sort((a, b) => b.date.compareTo(a.date));
    return sorted;
  }

  List<TransactionModel> searchTransactions(String query) {
    if (query.trim().isEmpty) {
      return [];
    }

    final lowerQuery = query.toLowerCase().trim();
    final results = <TransactionModel>[];

    // Try to parse as number for amount search
    final amountQuery = double.tryParse(lowerQuery);

    for (final transaction in _transactions) {
      bool matches = false;

      // Search in title
      if (transaction.title.toLowerCase().contains(lowerQuery)) {
        matches = true;
      }
      // Search in category
      else if (transaction.category.toLowerCase().contains(lowerQuery)) {
        matches = true;
      }
      // Search in description
      else if (transaction.description != null &&
          transaction.description!.toLowerCase().contains(lowerQuery)) {
        matches = true;
      }
      // Search in payment method
      else if (transaction.paymentMethod != null &&
          transaction.paymentMethod!.toLowerCase().contains(lowerQuery)) {
        matches = true;
      }
      // Search by amount (if query is a number)
      else if (amountQuery != null &&
          transaction.amount.toString().contains(lowerQuery)) {
        matches = true;
      }

      if (matches) {
        results.add(transaction);
      }
    }

    // Sort by date (most recent first)
    results.sort((a, b) => b.date.compareTo(a.date));

    return results;
  }

  void addTransaction(TransactionModel transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }

  void deleteTransaction(TransactionModel transaction) {
    _transactions.remove(transaction);
    notifyListeners();
  }

  void updateTransaction(
    TransactionModel oldTransaction,
    TransactionModel newTransaction,
  ) {
    final index = _transactions.indexOf(oldTransaction);
    if (index != -1) {
      _transactions[index] = newTransaction;
      notifyListeners();
    }
  }

  final List<VoidCallback> _listeners = [];

  void addListener(VoidCallback listener) {
    _listeners.add(listener);
  }

  void removeListener(VoidCallback listener) {
    _listeners.remove(listener);
  }

  void notifyListeners() {
    for (var listener in _listeners) {
      listener();
    }
  }
}
