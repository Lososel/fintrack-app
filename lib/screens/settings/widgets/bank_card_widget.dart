import 'package:flutter/material.dart';
import 'package:fintrack_app/models/card_model.dart';

class BankCardWidget extends StatelessWidget {
  final CardModel card;
  final VoidCallback onTap;
  final Color? backgroundColor;

  const BankCardWidget({
    super.key,
    required this.card,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBgColor = backgroundColor ?? (isDark ? const Color(0xFF181820) : Colors.white);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardBgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              ),
              child: card.assetPath.isNotEmpty
                  ? ClipOval(
                      child: Image.asset(
                        card.assetPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.account_balance,
                            color: isDark ? Colors.grey.shade400 : Colors.grey,
                          );
                        },
                      ),
                    )
                  : Icon(
                      Icons.account_balance,
                      color: isDark ? Colors.grey.shade400 : Colors.grey,
                    ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          card.bankName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "... ${card.cardNumber}",
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey.shade400 : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.category,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.grey.shade400 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              "\$${card.balance.toStringAsFixed(2)}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
