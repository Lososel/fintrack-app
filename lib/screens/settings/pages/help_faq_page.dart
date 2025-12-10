import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class HelpFAQPage extends StatefulWidget {
  const HelpFAQPage({super.key});

  @override
  State<HelpFAQPage> createState() => _HelpFAQPageState();
}

class _HelpFAQPageState extends State<HelpFAQPage> {
  final Map<int, bool> _expandedQuestions = {};

  void _toggleQuestion(int index) {
    setState(() {
      _expandedQuestions[index] = !(_expandedQuestions[index] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.grey.shade400 : Colors.black54;
    final cardColor = isDark ? theme.cardColor : Colors.white;

    final faqSections = [
      {
        'title': localizations.gettingStarted,
        'questions': [
          {
            'question': localizations.howDoIAddMyFirstTransaction,
            'answer': localizations.howDoIAddMyFirstTransactionAnswer,
          },
          {
            'question': localizations.howDoICreateABudget,
            'answer': localizations.howDoICreateABudgetAnswer,
          },
        ],
      },
      {
        'title': localizations.features,
        'questions': [
          {
            'question': localizations.howDoesTheCurrencyConverterWork,
            'answer': localizations.howDoesTheCurrencyConverterWorkAnswer,
          },
        ],
      },
      {
        'title': localizations.categories,
        'questions': [
          {
            'question': localizations.canICreateCustomCategories,
            'answer': localizations.canICreateCustomCategoriesAnswer,
          },
          {
            'question': localizations.howDoIEditOrDeleteACategory,
            'answer': localizations.howDoIEditOrDeleteACategoryAnswer,
          },
        ],
      },
      {
        'title': localizations.analyticsSection,
        'questions': [
          {
            'question': localizations.whatReportsAreAvailable,
            'answer': localizations.whatReportsAreAvailableAnswer,
          },
        ],
      },
      {
        'title': localizations.security,
        'questions': [
          {
            'question': localizations.isMyFinancialDataSecure,
            'answer': localizations.isMyFinancialDataSecureAnswer,
          },
          {
            'question': localizations.canIPasswordProtectTheApp,
            'answer': localizations.canIPasswordProtectTheAppAnswer,
          },
        ],
      },
    ];

    int questionIndex = 0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
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
                    icon: Icon(Icons.arrow_back_ios, color: textColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      localizations.helpAndFAQ,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: textColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ...faqSections.map((section) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      section['title'] as String,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ...(section['questions'] as List).map((qa) {
                      final index = questionIndex++;
                      final isExpanded = _expandedQuestions[index] ?? false;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GestureDetector(
                          onTap: () => _toggleQuestion(index),
                          child: Container(
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          qa['question'] as String,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: textColor,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Icon(
                                        isExpanded
                                            ? Icons.keyboard_arrow_up
                                            : Icons.keyboard_arrow_down,
                                        color: textColor,
                                      ),
                                    ],
                                  ),
                                ),
                                if (isExpanded)
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        16, 0, 16, 16),
                                    child: Text(
                                      qa['answer'] as String,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: secondaryTextColor,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    const SizedBox(height: 24),
                  ],
                );
              }).toList(),
              const SizedBox(height: 20),
              PrimaryButton(
                label: '${localizations.contactUs}: ${localizations.contactUsEmail}',
                onPressed: () {
                  // TODO: Open email client or copy to clipboard
                },
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

