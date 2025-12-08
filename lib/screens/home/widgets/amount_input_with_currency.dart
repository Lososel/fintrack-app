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
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black26),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  selectedCurrency.symbol,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
