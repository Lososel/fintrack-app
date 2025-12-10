import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/services/card_service.dart';
import 'package:fintrack_app/models/card_model.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  final CardService _cardService = CardService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _lastDigitsController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _purposeController = TextEditingController();

  String _selectedAccountType = "Debit";
  final List<String> _accountTypes = ["Debit", "Credit", "Savings", "Checking"];

  @override
  void dispose() {
    _cardNameController.dispose();
    _lastDigitsController.dispose();
    _balanceController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  String _getAssetPathForBank(String bankName) {
    // Use default bank icon for all cards
    return "";
  }

  String _extractBankName(String cardName) {
    // Try to extract bank name from card name (e.g., "Kaspi Gold" -> "Kaspi")
    final lowerName = cardName.toLowerCase();
    if (lowerName.contains("kaspi")) {
      return "Kaspi";
    } else if (lowerName.contains("halyk")) {
      return "Halyk";
    } else if (lowerName.contains("freedom")) {
      return "Freedom";
    }
    // Default or use first word
    return cardName.split(" ").first;
  }

  String? _validateCardName(String? value, BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    if (value == null || value.trim().isEmpty) {
      return localizations.cardNameRequired;
    }
    return null;
  }

  String? _validateLastDigits(String? value, BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    if (value == null || value.trim().isEmpty) {
      return localizations.last4DigitsRequiredError;
    }
    if (value.trim().length != 4 ||
        !RegExp(r'^\d{4}$').hasMatch(value.trim())) {
      return localizations.pleaseEnterExactly4Digits;
    }
    return null;
  }

  String? _validateBalance(String? value, BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    if (value == null || value.trim().isEmpty) {
      return localizations.balanceRequired;
    }
    if (double.tryParse(value.trim()) == null) {
      return localizations.pleaseEnterValidNumber;
    }
    return null;
  }

  String? _validatePurpose(String? value, BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    if (value == null || value.trim().isEmpty) {
      return localizations.primaryPurposeRequiredError;
    }
    return null;
  }

  void _handleAddCard() {
    if (_formKey.currentState!.validate()) {
      final cardName = _cardNameController.text.trim();
      final lastDigits = _lastDigitsController.text.trim();
      final balance = double.tryParse(_balanceController.text.trim()) ?? 0.0;
      final purpose = _purposeController.text.trim();

      final bankName = _extractBankName(cardName);
      final assetPath = _getAssetPathForBank(cardName);

      final localizations =
          AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
      final accountTypeDisplay = _selectedAccountType == "Debit"
          ? localizations.debitCard
          : _selectedAccountType == "Credit"
          ? localizations.creditCard
          : _selectedAccountType == "Savings"
          ? localizations.savingsAccount
          : localizations.checkingAccount;

      final newCard = CardModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        cardName: "Card${_cardService.cards.length + 1}",
        bankName: bankName,
        cardNumber: lastDigits,
        category: purpose,
        balance: balance,
        assetPath: "", // Use default icon
        accountType: accountTypeDisplay,
      );

      _cardService.addCard(newCard);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.cardAddedSuccessfully),
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F9),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        localizations.addNewCard,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Card / Account name
                Text(
                  localizations.cardAccountNameRequired,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _cardNameController,
                  decoration: InputDecoration(
                    hintText: localizations.egKaspiGold,
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) => _validateCardName(value, context),
                ),
                const SizedBox(height: 20),
                // Last 4 digits
                Text(
                  localizations.last4DigitsRequired,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _lastDigitsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: localizations.eg1234,
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) => _validateLastDigits(value, context),
                ),
                const SizedBox(height: 20),
                // Account Type
                Text(
                  localizations.accountTypeRequired,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: _accountTypes.map((type) {
                    final isSelected = _selectedAccountType == type;
                    String displayType;
                    switch (type) {
                      case "Debit":
                        displayType = localizations.debit;
                        break;
                      case "Credit":
                        displayType = localizations.credit;
                        break;
                      case "Savings":
                        displayType = localizations.savings;
                        break;
                      case "Checking":
                        displayType = localizations.checking;
                        break;
                      default:
                        displayType = type;
                    }
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: type != _accountTypes.last ? 8 : 0,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAccountType = type;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.black : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.black26,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              displayType,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                // Current balance
                Text(
                  localizations.currentBalanceRequired,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _balanceController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    hintText: "0.00",
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) => _validateBalance(value, context),
                ),
                const SizedBox(height: 20),
                // Primary purpose
                Text(
                  localizations.primaryPurposeRequired,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _purposeController,
                  decoration: InputDecoration(
                    hintText: localizations.egDailySpending,
                    hintStyle: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 18,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                  ),
                  validator: (value) => _validatePurpose(value, context),
                ),
                const SizedBox(height: 32),
                // Add new card button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleAddCard,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      localizations.addNewCard,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
