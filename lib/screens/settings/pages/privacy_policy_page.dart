import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.grey.shade400 : Colors.black54;

    final sections = [
      {
        'title': localizations.informationWeCollect,
        'content': localizations.informationWeCollectContent,
      },
      {
        'title': localizations.howWeUseYourInformation,
        'content': localizations.howWeUseYourInformationContent,
      },
      {
        'title': localizations.dataStorage,
        'content': localizations.dataStorageContent,
      },
      {
        'title': localizations.dataSecurity,
        'content': localizations.dataSecurityContent,
      },
      {
        'title': localizations.thirdPartyServices,
        'content': localizations.thirdPartyServicesContent,
      },
    ];

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
                      localizations.privacyPolicy,
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
              ...sections.map((section) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Column(
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
                      const SizedBox(height: 12),
                      Text(
                        section['content'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: secondaryTextColor,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

