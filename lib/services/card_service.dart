import 'package:flutter/material.dart';
import 'package:fintrack_app/models/card_model.dart';

class CardService {
  static final CardService _instance = CardService._internal();
  factory CardService() => _instance;
  CardService._internal();

  final List<CardModel> _cards = [
    CardModel(
      id: "1",
      cardName: "Card1",
      bankName: "Halyk",
      cardNumber: "4521",
      category: "Salary & Income",
      balance: 0.00,
      assetPath: "assets/halyk-bank.webp",
      accountType: "Debit Card",
    ),
    CardModel(
      id: "2",
      cardName: "Card2",
      bankName: "Kaspi",
      cardNumber: "8832",
      category: "Savings & Groceries",
      balance: 0.00,
      assetPath: "assets/kaspi.webp",
      accountType: "Savings Account",
    ),
    CardModel(
      id: "3",
      cardName: "Card3",
      bankName: "Freedom",
      cardNumber: "2194",
      category: "Entertainment & Travel",
      balance: 0.00,
      assetPath: "assets/freedom.webp",
      accountType: "Credit Card",
    ),
  ];

  List<CardModel> get cards => List.unmodifiable(_cards);

  void addCard(CardModel card) {
    _cards.add(card);
    notifyListeners();
  }

  void removeCard(String id) {
    _cards.removeWhere((card) => card.id == id);
    notifyListeners();
  }

  void updateCard(CardModel updatedCard) {
    final index = _cards.indexWhere((card) => card.id == updatedCard.id);
    if (index != -1) {
      _cards[index] = updatedCard;
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
