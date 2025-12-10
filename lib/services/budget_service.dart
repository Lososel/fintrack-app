import 'package:flutter/material.dart';
import 'package:fintrack_app/models/budget_model.dart';

class BudgetService {
  static final BudgetService _instance = BudgetService._internal();
  factory BudgetService() => _instance;
  BudgetService._internal();

  TotalBudgetModel? _totalBudget;
  final List<BudgetModel> _categoryBudgets = [];

  TotalBudgetModel? get totalBudget => _totalBudget;
  List<BudgetModel> get categoryBudgets => List.unmodifiable(_categoryBudgets);

  void setTotalBudget(TotalBudgetModel budget) {
    _totalBudget = budget;
    notifyListeners();
  }

  void addCategoryBudget(BudgetModel budget) {
    // Remove existing budget for this category if any
    _categoryBudgets.removeWhere((b) => b.category == budget.category);
    _categoryBudgets.add(budget);
    notifyListeners();
  }

  void updateCategoryBudget(BudgetModel oldBudget, BudgetModel newBudget) {
    final index = _categoryBudgets.indexOf(oldBudget);
    if (index != -1) {
      _categoryBudgets[index] = newBudget;
      notifyListeners();
    }
  }

  void deleteCategoryBudget(BudgetModel budget) {
    _categoryBudgets.remove(budget);
    notifyListeners();
  }

  BudgetModel? getCategoryBudget(String category) {
    try {
      return _categoryBudgets.firstWhere((b) => b.category == category);
    } catch (e) {
      return null;
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

