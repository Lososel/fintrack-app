import 'package:flutter/material.dart';
import 'package:fintrack_app/components/arrow/back_arrow.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/button/secondary_button.dart';
import 'package:fintrack_app/components/fields/input_field.dart';
import 'package:fintrack_app/components/toggle/transaction_toggle.dart';
import 'widgets/category_dropdown.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/modals/category_modal.dart';
import 'widgets/modals/date_picker_modal.dart';
import 'widgets/modals/payment_method_modal.dart';

final List<String> paymentMethods = [
  "Cash",
  "Credit Card",
  "Debit Card",
  "Bank Transfer",
  "Mobile Wallet",
  "Other",
];
final List<String> categories = [
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
final Map<String, IconData> categoryIcons = {
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

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  bool isExpense = true;

  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? selectedCategory;
  String selectedPayment = "Cash";

  DateTime selectedDate = DateTime.now();

  void _openCategorySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => CategorySelectModal(
        categories: categories,
        icons: categoryIcons,
        onSelected: (value) {
          setState(() => selectedCategory = value);
        },
      ),
    );
  }

  void _openPaymentMethodSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => PaymentMethodModal(
        methods: paymentMethods,
        onSelected: (value) {
          setState(() => selectedPayment = value);
        },
      ),
    );
  }

  void _openDatePickerSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => DatePickerModal(
        initialDate: selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030),
        onDateSelected: (date) {
          setState(() => selectedDate = date);
        },
      ),
    );
  }

  void _validateAndSubmit() {
    // Validate amount
    if (amountController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter an amount"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final amount = double.tryParse(amountController.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid amount"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Validate category
    if (selectedCategory == null || selectedCategory!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a category"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // If validation passes, proceed with submission
    // TODO: Implement actual transaction saving logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Transaction added successfully!"),
        backgroundColor: Colors.green,
      ),
    );
    
    // Optionally navigate back after successful submission
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackArrow(),
              const SizedBox(height: 10),

              const Text(
                "Add Transaction",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),

              const SizedBox(height: 20),

              TransactionToggle(
                isExpense: isExpense,
                onChanged: (value) => setState(() => isExpense = value),
              ),

              const SizedBox(height: 20),

              const Text(
                "Amount",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              InputField(
                hint: "0.00",
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),

              const SizedBox(height: 20),

              const Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              CategoryDropdown(
                current: selectedCategory ?? "Select category",
                onTap: _openCategorySheet,
              ),

              const SizedBox(height: 20),

              const Text(
                "Description",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              InputField(
                hint: "Enter description",
                controller: descriptionController,
              ),

              const SizedBox(height: 20),

              const Text("Date", style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 5),
              DatePickerField(
                date: selectedDate,
                onTap: _openDatePickerSheet,
              ),

              const SizedBox(height: 20),

              const Text(
                "Payment Method",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 5),
              CategoryDropdown(
                current: selectedPayment,
                onTap: _openPaymentMethodSheet,
              ),

              const SizedBox(height: 40),

              PrimaryButton(
                label: "Add Transaction",
                onPressed: () {
                  _validateAndSubmit();
                },
              ),

              const SizedBox(height: 16),

              SecondaryButton(
                label: "Cancel",
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
