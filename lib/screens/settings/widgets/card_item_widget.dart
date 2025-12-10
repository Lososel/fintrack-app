import 'package:flutter/material.dart';
import 'package:fintrack_app/models/card_model.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class CardItemWidget extends StatelessWidget {
  final CardModel card;
  final VoidCallback onTap;

  const CardItemWidget({super.key, required this.card, required this.onTap});

  String _getAccountTypeDisplay(String accountType, BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    switch (accountType) {
      case "Debit":
        return localizations.debitCard;
      case "Credit":
        return localizations.creditCard;
      case "Savings":
        return localizations.savingsAccount;
      case "Checking":
        return localizations.checkingAccount;
      default:
        return accountType;
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF181820) : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Bank Logo
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
                                size: 24,
                              );
                            },
                          ),
                        )
                      : Icon(
                          Icons.account_balance,
                          color: isDark ? Colors.grey.shade400 : Colors.grey,
                          size: 24,
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Row(
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
                        ".... ${card.cardNumber}",
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  _getAccountTypeDisplay(card.accountType, context),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.white70 : Colors.black87,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Balance",
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.grey.shade400 : Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizations.purpose,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? Colors.grey.shade400 : Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      card.category,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
