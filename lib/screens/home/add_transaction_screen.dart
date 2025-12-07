import 'package:flutter/material.dart';
import 'package:fintrack_app/components/arrow/back_arrow.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/button/secondary_button.dart';
import 'package:fintrack_app/components/fields/input_field.dart';
import 'package:fintrack_app/components/toggle/transaction_toggle.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'widgets/category_dropdown.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/modals/category_modal.dart';
import 'widgets/modals/date_picker_modal.dart';
import 'widgets/modals/payment_method_modal.dart';
import 'transaction_details_screen.dart';

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

  Future<T?> _showSmoothModal<T>({
    required BuildContext context,
    required Widget child,
  }) {
    return Navigator.of(context).push<T>(
      _SmoothModalRoute<T>(
        builder: (_) => child,
        barrierColor: Colors.black.withOpacity(0.5),
        isDismissible: true,
        enableDrag: true,
      ),
    );
  }

  void _openCategorySheet() {
    _showSmoothModal(
      context: context,
      child: CategorySelectModal(
        categories: categories,
        icons: categoryIcons,
        onSelected: (value) {
          setState(() => selectedCategory = value);
        },
      ),
    );
  }

  void _openPaymentMethodSheet() {
    _showSmoothModal(
      context: context,
      child: PaymentMethodModal(
        methods: paymentMethods,
        onSelected: (value) {
          setState(() => selectedPayment = value);
        },
      ),
    );
  }

  void _openDatePickerSheet() {
    _showSmoothModal(
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
        ),
      ),
    );
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
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
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
              DatePickerField(date: selectedDate, onTap: _openDatePickerSheet),

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

class _SmoothModalRoute<T> extends ModalRoute<T> {
  final WidgetBuilder builder;
  final Color? _barrierColor;
  final bool isDismissible;
  final bool enableDrag;

  _SmoothModalRoute({
    required this.builder,
    Color? barrierColor,
    this.isDismissible = true,
    this.enableDrag = true,
  }) : _barrierColor = barrierColor;

  @override
  Color? get barrierColor => _barrierColor;

  @override
  bool get opaque => false;

  @override
  String? get barrierLabel => 'Dismiss';

  @override
  bool get barrierDismissible => isDismissible;

  @override
  bool get maintainState => false;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Material(
          color: Colors.transparent,
          child: SafeArea(
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              decoration: const BoxDecoration(
                color: Color(0xffF4F4F7),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
                child: builder(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const begin = Offset(0.0, 1.0);
    const end = Offset.zero;
    final curve = Curves.easeOutCubic;
    final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(
      position: animation.drive(tween),
      child: FadeTransition(opacity: animation, child: child),
    );
  }
}
