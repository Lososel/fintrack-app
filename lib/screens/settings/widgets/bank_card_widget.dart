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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.shade100,
              ),
              child: card.assetPath.isNotEmpty
                  ? ClipOval(
                      child: Image.asset(
                        card.assetPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.account_balance, color: Colors.grey);
                        },
                      ),
                    )
                  : const Icon(Icons.account_balance, color: Colors.grey),
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
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "... ${card.cardNumber}",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    card.category,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Text(
                "\$${card.balance.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.right,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

