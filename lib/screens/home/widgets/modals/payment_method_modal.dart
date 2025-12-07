import 'package:flutter/material.dart';
import 'package:fintrack_app/components/modal/app_modal.dart';
import 'package:fintrack_app/components/modal/animated_selectable_tile.dart';

class PaymentMethodModal extends StatelessWidget {
  final List<String> methods;
  final Function(String) onSelected;

  const PaymentMethodModal({
    super.key,
    required this.methods,
    required this.onSelected,
  });

  IconData _iconForMethod(String m) {
    switch (m) {
      case "Cash":
        return Icons.payments_outlined;
      case "Credit Card":
        return Icons.credit_card;
      case "Debit Card":
        return Icons.credit_score_outlined;
      case "Bank Transfer":
        return Icons.account_balance;
      case "Mobile Wallet":
        return Icons.phone_iphone;
      default:
        return Icons.more_horiz;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppModal(
      title: "Select Payment Method",
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: ListView(
          shrinkWrap: true,
          children: methods.map((method) {
            return AnimatedSelectableTile(
              title: method,
              icon: _iconForMethod(method),
              onTap: () {
                onSelected(method);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
