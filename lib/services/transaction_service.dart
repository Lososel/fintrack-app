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

  void addTransaction(TransactionModel transaction) {
    _transactions.insert(0, transaction);
    notifyListeners();
  }

  void deleteTransaction(TransactionModel transaction) {
    _transactions.remove(transaction);
    notifyListeners();
  }

  void updateTransaction(TransactionModel oldTransaction, TransactionModel newTransaction) {
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

