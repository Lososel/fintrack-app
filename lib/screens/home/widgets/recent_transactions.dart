import 'package:flutter/material.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/components/transaction/swipeable_transaction_item.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class RecentTransactions extends StatelessWidget {
  final List<TransactionModel> transactions;

  const RecentTransactions({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.recentTransactions,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        if (transactions.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              localizations.noTransactionsYet,
              style: const TextStyle(color: Colors.black54),
            ),
          )
        else
          for (var tx in transactions) SwipeableTransactionItem(transaction: tx),
      ],
    );
  }
}
