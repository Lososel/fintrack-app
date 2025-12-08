import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/services/card_service.dart';
import 'package:fintrack_app/models/card_model.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class EditCardPage extends StatefulWidget {
  final CardModel card;

  const EditCardPage({super.key, required this.card});

  @override
  State<EditCardPage> createState() => _EditCardPageState();
}

class _EditCardPageState extends State<EditCardPage> {
  final CardService _cardService = CardService();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _cardNameController;
  late TextEditingController _lastDigitsController;
  late TextEditingController _balanceController;
  late TextEditingController _purposeController;

  late String _selectedAccountType;
  final List<String> _accountTypes = ["Debit", "Credit", "Savings", "Checking"];

  @override
  void initState() {
    super.initState();
    _cardNameController = TextEditingController(text: widget.card.bankName);
    _lastDigitsController = TextEditingController(text: widget.card.cardNumber);
    _balanceController = TextEditingController(
      text: widget.card.balance.toStringAsFixed(2),
    );
    _purposeController = TextEditingController(text: widget.card.category);

    // Convert display name back to short form for selection
    final accountType = widget.card.accountType;
    if (accountType.contains("Debit")) {
      _selectedAccountType = "Debit";
    } else if (accountType.contains("Credit")) {
      _selectedAccountType = "Credit";
    } else if (accountType.contains("Savings")) {
      _selectedAccountType = "Savings";
    } else if (accountType.contains("Checking")) {
      _selectedAccountType = "Checking";
    } else {
      _selectedAccountType = "Debit";
    }
  }

  @override
  void dispose() {
    _cardNameController.dispose();
    _lastDigitsController.dispose();
    _balanceController.dispose();
    _purposeController.dispose();
    super.dispose();
  }

  String _getAccountTypeDisplay(String accountType, BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    switch (accountType) {
      case "Debit":
        return localizations.debitCard;
      case "Credit":
        return localizations.creditCard;
      case "Savings":
        return localizations.savingsAccount;
      case "Checking":
        return localizations.checkingAccount;
      default:
        return accountType;
    }
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

  void _handleSaveChanges() {
    if (_formKey.currentState!.validate()) {
      final localizations =
          AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
      final cardName = _cardNameController.text.trim();
      final lastDigits = _lastDigitsController.text.trim();
      final balance = double.tryParse(_balanceController.text.trim()) ?? 0.0;
      final purpose = _purposeController.text.trim();

      final accountTypeDisplay = _getAccountTypeDisplay(
        _selectedAccountType,
        context,
      );

      final updatedCard = CardModel(
        id: widget.card.id,
        cardName: widget.card.cardName,
        bankName: cardName,
        cardNumber: lastDigits,
        category: purpose,
        balance: balance,
        assetPath: widget.card.assetPath,
        accountType: accountTypeDisplay,
      );

      _cardService.updateCard(updatedCard);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.cardUpdatedSuccessfully),
          duration: const Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    }
  }

  void _handleCancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

    // Create validator wrappers that capture context
    String? Function(String?) validateCardName = (value) =>
        _validateCardName(value, context);
    String? Function(String?) validateLastDigits = (value) =>
        _validateLastDigits(value, context);
    String? Function(String?) validateBalance = (value) =>
        _validateBalance(value, context);
    String? Function(String?) validatePurpose = (value) =>
        _validatePurpose(value, context);

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
                      icon: const Icon(Icons.arrow_back, color: Colors.black),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        localizations.editCard,
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
                const SizedBox(height: 20),
                // Card Summary Display
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey.shade100,
                            ),
                            child: widget.card.assetPath.isNotEmpty
                                ? ClipOval(
                                    child: Image.asset(
                                      widget.card.assetPath,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                            return const Icon(
                                              Icons.account_balance,
                                              color: Colors.grey,
                                            );
                                          },
                                    ),
                                  )
                                : const Icon(
                                    Icons.account_balance,
                                    color: Colors.grey,
                                  ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.card.bankName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "... ${widget.card.cardNumber}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            widget.card.accountType,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localizations.balance,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${widget.card.balance.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                localizations.purpose,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.card.category,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
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
                    fillColor: Colors.grey.shade200,
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
                  validator: validateCardName,
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
                    fillColor: Colors.grey.shade200,
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
                  validator: validateLastDigits,
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
                    fillColor: Colors.grey.shade200,
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
                  validator: validateBalance,
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
                    fillColor: Colors.grey.shade200,
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
                  validator: validatePurpose,
                ),
                const SizedBox(height: 32),
                // Save Changes Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _handleSaveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Save Changes",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Cancel Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _handleCancel,
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      localizations.cancel,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
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
