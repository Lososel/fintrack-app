import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/services/language_service.dart';
import 'package:fintrack_app/screens/settings/widgets/language_option_widget.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final LanguageService _languageService = LanguageService();

  @override
  void initState() {
    super.initState();
    _languageService.addListener(_refresh);
  }

  @override
  void dispose() {
    _languageService.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  void _selectLanguage(String languageCode, String languageName) {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    _languageService.setLanguageByCode(languageCode);
    // Pop the language page
    Navigator.pop(context);
    // Show a snackbar to confirm the change
    // Note: The app will rebuild automatically via the LanguageService listener in main.dart
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${localizations.languageChangedTo} $languageName'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final currentLanguageCode = _languageService.currentLanguageCode;

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F9),
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
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      localizations.language,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              LanguageOptionWidget(
                languageCode: 'en',
                languageName: 'English',
                isSelected: currentLanguageCode == 'en',
                onTap: () => _selectLanguage('en', 'English'),
              ),
              const SizedBox(height: 12),
              LanguageOptionWidget(
                languageCode: 'ru',
                languageName: 'Russian',
                isSelected: currentLanguageCode == 'ru',
                onTap: () => _selectLanguage('ru', 'Russian'),
              ),
              const SizedBox(height: 12),
              LanguageOptionWidget(
                languageCode: 'kk',
                languageName: 'Kazakh',
                isSelected: currentLanguageCode == 'kk',
                onTap: () => _selectLanguage('kk', 'Kazakh'),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
