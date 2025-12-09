import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/app_localizations.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/button/secondary_button.dart';
import 'package:fintrack_app/components/fields/input_field.dart';
import 'package:fintrack_app/components/toggle/transaction_toggle.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/utils/modal_helper.dart';
import 'widgets/amount_input_with_currency.dart';
import 'widgets/category_dropdown.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/modals/category_modal.dart';
import 'widgets/modals/date_picker_modal.dart';
import 'widgets/modals/payment_method_modal.dart';
import 'widgets/modals/currency_modal.dart';
import 'widgets/utils/transaction_constants.dart';
import 'widgets/transaction_form_validator.dart';
import 'transaction_details_screen.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool isExpense = true;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;
  String selectedPayment = "Cash";
  Currency selectedCurrency = Currency.dollar;

  DateTime selectedDate = DateTime.now();

  void _openCategorySheet() {
    ModalHelper.showSmoothModal(
      context: context,
      child: CategorySelectModal(
        categories: TransactionConstants.categories,
        icons: TransactionConstants.categoryIcons,
        onSelected: (value) {
          setState(() => selectedCategory = value);
        },
      ),
    );
  }

  void _openPaymentMethodSheet() {
    ModalHelper.showSmoothModal(
      context: context,
      child: PaymentMethodModal(
        methods: TransactionConstants.paymentMethods,
        onSelected: (value) {
          setState(() => selectedPayment = value);
        },
      ),
    );
  }

  void _openDatePickerSheet() {
    ModalHelper.showSmoothModal(
      context: context,
      child: DatePickerModal(
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        onDateSelected: (date) {
          setState(() => selectedDate = date);
        },
      ),
    );
  }

  void _openCurrencySheet() {
    ModalHelper.showSmoothModal(
      context: context,
      child: CurrencyModal(
        selectedCurrency: selectedCurrency,
        onSelected: (currency) {
          setState(() => selectedCurrency = currency);
        },
      ),
    );
  }

  void _validateAndSubmit() {
    // Validate amount
    final amountError = TransactionFormValidator.validateAmount(
      amountController.text.trim(),
    );
    if (amountError != null) {
      TransactionFormValidator.showErrorSnackBar(context, amountError);
      return;
    }

    // Validate category
    final categoryError = TransactionFormValidator.validateCategory(selectedCategory);
    if (categoryError != null) {
      TransactionFormValidator.showErrorSnackBar(context, categoryError);
      return;
    }

    // If validation passes, proceed with submission
    final amount = double.parse(amountController.text.trim());
    final description = descriptionController.text.trim().isEmpty
        ? "No description"
        : descriptionController.text.trim();

    // Create and save transaction
    final transaction = TransactionModel(
      title: description,
      category: selectedCategory!,
      amount: amount,
      date: selectedDate,
      isIncome: !isExpense,
      paymentMethod: selectedPayment,
      description: description,
      currency: selectedCurrency,
    );

    // Save transaction
    TransactionService().addTransaction(transaction);

    // Navigate to transaction details screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionDetailsScreen(
          category: selectedCategory!,
          amount: amount,
          date: selectedDate,
          isExpense: isExpense,
          paymentMethod: selectedPayment,
          description: description,
          currency: selectedCurrency,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
                  Text(
                    localizations.addTransaction,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              TransactionToggle(
                isExpense: isExpense,
                onChanged: (value) => setState(() => isExpense = value),
              ),

              const SizedBox(height: 20),

              Builder(
                builder: (context) {
                  final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizations.amount,
                        style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              AmountInputWithCurrency(
                amountController: amountController,
                selectedCurrency: selectedCurrency,
                onCurrencyTap: _openCurrencySheet,
              ),

              const SizedBox(height: 20),

                      Text(
                        localizations.category,
                        style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              CategoryDropdown(
                        current: selectedCategory ?? localizations.selectCategory,
                onTap: _openCategorySheet,
              ),

              const SizedBox(height: 20),

                      Text(
                        localizations.description,
                        style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              InputField(
                        hint: localizations.enterDescription,
                controller: descriptionController,
              ),

              const SizedBox(height: 20),

                      Text(localizations.date, style: const TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              DatePickerField(date: selectedDate, onTap: _openDatePickerSheet),

              const SizedBox(height: 20),

                      Text(
                        localizations.paymentMethod,
                        style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              CategoryDropdown(
                current: selectedPayment,
                onTap: _openPaymentMethodSheet,
              ),

              const SizedBox(height: 40),

              PrimaryButton(
                        label: localizations.addTransaction,
                onPressed: () {
                  _validateAndSubmit();
                },
              ),

              const SizedBox(height: 16),

              SecondaryButton(
                        label: localizations.cancel,
                onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
