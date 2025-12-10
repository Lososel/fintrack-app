import 'package:flutter/material.dart';
import 'package:fintrack_app/components/modal/app_modal.dart';
import 'package:fintrack_app/components/modal/animated_selectable_tile.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class CurrencyModal extends StatefulWidget {
  final Currency selectedCurrency;
  final Function(Currency) onSelected;

  const CurrencyModal({
    super.key,
    required this.selectedCurrency,
    required this.onSelected,
  });

  @override
  State<CurrencyModal> createState() => _CurrencyModalState();
}

class _CurrencyModalState extends State<CurrencyModal> {
  IconData _getCurrencyIcon(Currency currency) {
    switch (currency) {
      case Currency.dollar:
        return Icons.attach_money;
      case Currency.tenge:
        return Icons.currency_exchange; // Using currency_exchange as tenge icon
      case Currency.euro:
        return Icons.euro;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    return AppModal(
      title: localizations.selectCurrency,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: ListView(
          shrinkWrap: true,
          children: Currency.values.map((currency) {
            // For tenge, show the symbol as text instead of icon
            if (currency == Currency.tenge) {
              return _TengeSelectableTile(
                title: '${currency.name} (${currency.symbol})',
                symbol: currency.symbol,
                onTap: () {
                  widget.onSelected(currency);
                  Navigator.pop(context);
                },
              );
            }
            return AnimatedSelectableTile(
              title: '${currency.name} (${currency.symbol})',
              icon: _getCurrencyIcon(currency),
              onTap: () {
                widget.onSelected(currency);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _TengeSelectableTile extends StatefulWidget {
  final String title;
  final String symbol;
  final VoidCallback onTap;

  const _TengeSelectableTile({
    required this.title,
    required this.symbol,
    required this.onTap,
  });

  @override
  State<_TengeSelectableTile> createState() => _TengeSelectableTileState();
}

class _TengeSelectableTileState extends State<_TengeSelectableTile> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapCancel: () => setState(() => isPressed = false),
      onTapUp: (_) => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isPressed
              ? (isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade200)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              child: Text(
                widget.symbol,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white70 : Colors.black87,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
