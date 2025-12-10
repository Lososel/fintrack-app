import 'package:flutter/material.dart';
import 'package:fintrack_app/components/fields/input_field.dart';
import 'package:fintrack_app/utils/currency.dart';

class AmountInputWithCurrency extends StatelessWidget {
  final TextEditingController amountController;
  final Currency selectedCurrency;
  final VoidCallback onCurrencyTap;

  const AmountInputWithCurrency({
    super.key,
    required this.amountController,
    required this.selectedCurrency,
    required this.onCurrencyTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final buttonBackgroundColor = isDark ? Colors.grey.shade800 : Colors.grey.shade200;
    final textColor = isDark ? Colors.white : Colors.black;
    final borderColor = isDark ? Colors.grey.shade700 : Colors.black26;
    
    return Row(
      children: [
        Expanded(
          child: InputField(
            hint: "0.00",
            controller: amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: onCurrencyTap,
          child: Container(
            height: 56,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            decoration: BoxDecoration(
              color: buttonBackgroundColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedCurrency.symbol,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down, size: 20, color: textColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
