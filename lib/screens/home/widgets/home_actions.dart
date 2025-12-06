import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/action_buttons.dart';

class HomeActions extends StatelessWidget {
  const HomeActions({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionButtons(
      onAddTransaction: () {
        // TODO: open add transaction modal
      },
      onViewAll: () {
        // TODO: navigate to full transaction list
      },
    );
  }
}
