import 'package:flutter/material.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/components/transaction/transaction_item.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/screens/home/add_transaction_screen.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class SwipeableTransactionItem extends StatefulWidget {
  final TransactionModel transaction;

  const SwipeableTransactionItem({
    super.key,
    required this.transaction,
  });

  @override
  State<SwipeableTransactionItem> createState() =>
      _SwipeableTransactionItemState();
}

class _SwipeableTransactionItemState extends State<SwipeableTransactionItem>
    with SingleTickerProviderStateMixin {
  final TransactionService _transactionService = TransactionService();
  double _dragOffset = 0.0;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      // Only allow swiping left (negative direction)
      if (details.primaryDelta != null) {
        _dragOffset = (_dragOffset + details.primaryDelta!).clamp(-120.0, 0.0);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    // If dragged more than 60 pixels, snap to open position
    if (_dragOffset < -60) {
      _controller.forward();
      setState(() {
        _dragOffset = -120.0;
      });
    } else {
      // Otherwise, snap back to closed position
      _controller.reverse();
      setState(() {
        _dragOffset = 0.0;
      });
    }
  }

  void _closeActions() {
    _controller.reverse();
    setState(() {
      _dragOffset = 0.0;
    });
  }

  void _handleEdit() {
    _closeActions();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTransactionScreen(
          transactionToEdit: widget.transaction,
        ),
      ),
    );
  }

  void _handleDelete() {
    _closeActions();
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizations.deleteTransaction),
          content: Text(localizations.deleteTransactionConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localizations.cancel),
            ),
            TextButton(
              onPressed: () {
                _transactionService.deleteTransaction(widget.transaction);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(localizations.transactionDeleted),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text(localizations.delete),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Stack(
        children: [
          // Action buttons (background)
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Edit button
                  Builder(
                    builder: (context) {
                      final localizations =
                          AppLocalizations.of(context) ??
                          AppLocalizations(const Locale('en'));
                      return Container(
                        width: 60,
                        color: Colors.blue,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _handleEdit,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.edit, color: Colors.white, size: 24),
                                const SizedBox(height: 4),
                                Text(
                                  localizations.edit,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  // Delete button
                  Builder(
                    builder: (context) {
                      final localizations =
                          AppLocalizations.of(context) ??
                          AppLocalizations(const Locale('en'));
                      return Container(
                        width: 60,
                        color: Colors.red,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _handleDelete,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.delete, color: Colors.white, size: 24),
                                const SizedBox(height: 4),
                                Text(
                                  localizations.delete,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          // Transaction item (foreground)
          Transform.translate(
            offset: Offset(_dragOffset, 0),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: TransactionItem(transaction: widget.transaction),
            ),
          ),
        ],
      ),
    );
  }
}

