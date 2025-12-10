import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/components/cards/balance_card.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/services/user_service.dart';
import 'package:fintrack_app/services/card_service.dart';
import 'package:fintrack_app/services/currency_conversion_service.dart';
import 'package:fintrack_app/screens/settings/pages/edit_profile_page.dart';
import 'package:fintrack_app/screens/settings/pages/add_card_page.dart';
import 'package:fintrack_app/screens/settings/pages/manage_cards_page.dart';
import 'package:fintrack_app/screens/settings/pages/edit_card_page.dart';
import 'package:fintrack_app/screens/settings/widgets/bank_card_widget.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TransactionService _transactionService = TransactionService();
  final UserService _userService = UserService();
  final CardService _cardService = CardService();

  @override
  void initState() {
    super.initState();
    _transactionService.addListener(_refresh);
    _userService.addListener(_refresh);
    _cardService.addListener(_refresh);
  }

  @override
  void dispose() {
    _transactionService.removeListener(_refresh);
    _userService.removeListener(_refresh);
    _cardService.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  Future<Map<String, double>> _calculateTotals() async {
    final conversionService = CurrencyConversionService();
    double income = 0;
    double expense = 0;

    for (var transaction in _transactionService.transactions) {
      final convertedAmount = await conversionService.convertToBase(
        transaction.amount,
        transaction.currency,
      );
      if (transaction.isIncome) {
        income += convertedAmount;
      } else {
        expense += convertedAmount;
      }
    }

    return {'income': income, 'expense': expense, 'total': income - expense};
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final transactionCount = _transactionService.transactions.length;
    final cards = _cardService.cards;

    // Calculate total balance from all cards (sum of all card balances)
    final totalBalance = cards.fold<double>(
      0.0,
      (sum, card) => sum + card.balance,
    );

    final theme = Theme.of(context);
    final textColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    final iconColor = theme.brightness == Brightness.dark ? Colors.white : Colors.black;
    final cardColor = theme.cardColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      bottomNavigationBar: const HomeBottomNav(currentIndex: 3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: iconColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    localizations.profile,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: textColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Profile Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.brightness == Brightness.dark
                            ? Colors.grey.shade800
                            : Colors.grey.shade300,
                      ),
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: theme.brightness == Brightness.dark
                            ? Colors.grey.shade400
                            : Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userService.name ?? localizations.user,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () {
                              // TODO: Handle email tap
                            },
                            child: Text(
                              _userService.email ?? "email@example.com",
                              style: TextStyle(
                                fontSize: 14,
                                color: theme.brightness == Brightness.dark
                                    ? Colors.grey.shade400
                                    : Colors.grey,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _userService.location ?? "Unknown",
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.grey.shade400
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.edit_outlined,
                        color: iconColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditProfilePage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Summary Statistics
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        color: theme.brightness == Brightness.dark 
                            ? Colors.grey.shade800 
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "$transactionCount",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            localizations.recentTransactions,
                            style: TextStyle(
                              fontSize: 12,
                              color: theme.brightness == Brightness.dark
                                  ? Colors.grey.shade400
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FutureBuilder<Map<String, double>>(
                    future: _calculateTotals(),
                    builder: (context, snapshot) {
                      final totals = snapshot.data ?? {'income': 0.0, 'expense': 0.0};
                      return Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: theme.brightness == Brightness.dark 
                                ? Colors.grey.shade800 
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                snapshot.connectionState == ConnectionState.waiting
                                    ? "..."
                                    : "\$${totals['income']!.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                localizations.income,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.brightness == Brightness.dark
                                      ? Colors.grey.shade400
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 12),
                  FutureBuilder<Map<String, double>>(
                    future: _calculateTotals(),
                    builder: (context, snapshot) {
                      final totals = snapshot.data ?? {'income': 0.0, 'expense': 0.0};
                      return Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: theme.brightness == Brightness.dark 
                                ? Colors.grey.shade800 
                                : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              Text(
                                snapshot.connectionState == ConnectionState.waiting
                                    ? "..."
                                    : "\$${totals['expense']!.toStringAsFixed(0)}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                localizations.expense,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: theme.brightness == Brightness.dark
                                      ? Colors.grey.shade400
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Total Balance Card
              FutureBuilder<Map<String, double>>(
                future: _calculateTotals(),
                builder: (context, snapshot) {
                  final totals = snapshot.data ?? {'income': 0.0, 'expense': 0.0, 'total': 0.0};
                  return BalanceCard(
                    totalBalance: totalBalance,
                    income: totals['income']!,
                    expense: totals['expense']!,
                    title: localizations.totalBalance,
                  );
                },
              ),
              const SizedBox(height: 20),
              // Bank Cards List
              ...cards.map(
                (card) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: BankCardWidget(
                    card: card,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditCardPage(card: card),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Action Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddCardPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.brightness == Brightness.dark
                        ? const Color(0xFF181820)
                        : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    localizations.addNewCard,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ManageCardsPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.brightness == Brightness.dark
                        ? const Color(0xFF181820)
                        : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    localizations.manageCards,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
