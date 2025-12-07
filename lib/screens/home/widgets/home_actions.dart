import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/action_buttons.dart';
import 'package:fintrack_app/screens/home/add_transaction_screen.dart';

class HomeActions extends StatelessWidget {
  const HomeActions({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionButtons(
      onAddTransaction: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddTransactionScreen()),
        );
      },
      onViewAll: () {
        // TODO: navigate to full transaction list
      },
    );
  }
}
