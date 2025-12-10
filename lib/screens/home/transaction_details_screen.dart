import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/screens/home/add_transaction_screen.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'widgets/transaction_amount_header.dart';
import 'widgets/transaction_details_card.dart';
import 'widgets/transaction_action_buttons.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class TransactionDetailsScreen extends StatefulWidget {
  final String category;
  final double amount;
  final DateTime date;
  final bool isExpense;
  final String paymentMethod;
  final String description;
  final Currency currency;
  final TransactionModel? transaction;

  const TransactionDetailsScreen({
    super.key,
    required this.category,
    required this.amount,
    required this.date,
    required this.isExpense,
    required this.paymentMethod,
    required this.description,
    this.currency = Currency.dollar,
    this.transaction,
  });

  @override
  State<TransactionDetailsScreen> createState() => _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  final TransactionService _transactionService = TransactionService();
  TransactionModel? _currentTransaction;
  int? _transactionIndex;

  @override
  void initState() {
    super.initState();
    _transactionService.addListener(_refreshTransaction);
    _findCurrentTransaction();
  }

  @override
  void dispose() {
    _transactionService.removeListener(_refreshTransaction);
    super.dispose();
  }

  void _refreshTransaction() {
    _findCurrentTransaction();
    setState(() {});
  }

  void _findCurrentTransaction() {
    // First, try to use the stored index if we have it
    if (_transactionIndex != null && 
        _transactionIndex! < _transactionService.transactions.length) {
      _currentTransaction = _transactionService.transactions[_transactionIndex!];
      return;
    }

    // Otherwise, try to find it by matching
    if (widget.transaction != null) {
      // If transaction was provided, try to find it in the service
      try {
        final index = _transactionService.transactions.indexWhere(
          (t) =>
              t.amount == widget.transaction!.amount &&
              t.category == widget.transaction!.category &&
              t.date.year == widget.transaction!.date.year &&
              t.date.month == widget.transaction!.date.month &&
              t.date.day == widget.transaction!.date.day &&
              t.isIncome == widget.transaction!.isIncome &&
              t.currency == widget.transaction!.currency,
        );
        if (index != -1) {
          _transactionIndex = index;
          _currentTransaction = _transactionService.transactions[index];
          return;
        }
      } catch (e) {
        // Continue to fallback
      }
    }
    
    // Try to find the transaction by matching widget parameters
    try {
      final index = _transactionService.transactions.indexWhere(
        (t) =>
            t.amount == widget.amount &&
            t.category == widget.category &&
            t.date.year == widget.date.year &&
            t.date.month == widget.date.month &&
            t.date.day == widget.date.day &&
            t.isIncome == !widget.isExpense &&
            t.currency == widget.currency,
      );
      if (index != -1) {
        _transactionIndex = index;
        _currentTransaction = _transactionService.transactions[index];
        return;
      }
    } catch (e) {
      // Continue to fallback
    }

    // If not found, use fallback
    if (widget.transaction != null) {
      _currentTransaction = widget.transaction;
    } else {
      _currentTransaction = null;
    }
  }

  TransactionModel get _displayTransaction {
    // Always try to get from service first using index
    if (_transactionIndex != null && 
        _transactionIndex! < _transactionService.transactions.length) {
      return _transactionService.transactions[_transactionIndex!];
    }
    
    // Fallback to stored current transaction
    if (_currentTransaction != null) {
      return _currentTransaction!;
    }
    
    // Final fallback to widget parameters if transaction not found
    return TransactionModel(
      title: widget.description,
      category: widget.category,
      amount: widget.amount,
      date: widget.date,
      isIncome: !widget.isExpense,
      paymentMethod: widget.paymentMethod,
      description: widget.description,
      currency: widget.currency,
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final displayTx = _displayTransaction;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D0D10) : const Color(0xffF4F4F7),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          localizations.transactionDetails,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    TransactionAmountHeader(
                      amount: displayTx.amount,
                      isExpense: !displayTx.isIncome,
                      currency: displayTx.currency,
                    ),
                    const SizedBox(height: 30),
                    TransactionDetailsCard(
                      category: displayTx.category,
                      date: displayTx.date,
                      paymentMethod: displayTx.paymentMethod ?? '',
                      description: displayTx.description ?? displayTx.title,
                    ),
                    const SizedBox(height: 30),
                    TransactionActionButtons(
                      onEdit: () {
                        final localizations =
                            AppLocalizations.of(context) ??
                            AppLocalizations(const Locale('en'));
                        // Use the current transaction if available
                        TransactionModel? transactionToEdit = _currentTransaction;
                        if (transactionToEdit == null) {
                          // Try to find it
                          try {
                            transactionToEdit = _transactionService.transactions.firstWhere(
                              (t) =>
                                  t.amount == displayTx.amount &&
                                  t.category == displayTx.category &&
                                  t.date.year == displayTx.date.year &&
                                  t.date.month == displayTx.date.month &&
                                  t.date.day == displayTx.date.day &&
                                  t.isIncome == displayTx.isIncome &&
                                  t.currency == displayTx.currency,
                            );
                          } catch (e) {
                            // If transaction not found, show error and return
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(localizations.transactionNotFound),
                              ),
                            );
                            return;
                          }
                        }
                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTransactionScreen(
                              transactionToEdit: transactionToEdit,
                            ),
                          ),
                        ).then((_) {
                          // Refresh when returning from edit screen
                          _refreshTransaction();
                        });
                      },
                      onDelete: () {
                        // TODO: Show delete confirmation
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // Bottom Navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF181820) : Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black.withOpacity(0.3) : Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: const HomeBottomNav(),
            ),
          ],
        ),
      ),
    );
  }
}
