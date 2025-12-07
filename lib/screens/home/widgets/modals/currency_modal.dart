import 'package:flutter/material.dart';
import 'package:fintrack_app/components/modal/app_modal.dart';
import 'package:fintrack_app/components/modal/animated_selectable_tile.dart';
import 'package:fintrack_app/utils/currency.dart';

class CurrencyModal extends StatelessWidget {
  final Currency selectedCurrency;
  final Function(Currency) onSelected;

  const CurrencyModal({
    super.key,
    required this.selectedCurrency,
    required this.onSelected,
  });

  IconData _getCurrencyIcon(Currency currency) {
    switch (currency) {
      case Currency.dollar:
        return Icons.attach_money;
      case Currency.tenge:
        return Icons.currency_ruble;
      case Currency.euro:
        return Icons.euro;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppModal(
      title: "Select Currency",
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: ListView(
          shrinkWrap: true,
          children: Currency.values.map((currency) {
            return AnimatedSelectableTile(
              title: '${currency.name} (${currency.symbol})',
              icon: _getCurrencyIcon(currency),
              onTap: () {
                onSelected(currency);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

