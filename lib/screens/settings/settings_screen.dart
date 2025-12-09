import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/screens/settings/pages/profile_page.dart';
import 'package:fintrack_app/screens/settings/pages/currency_page.dart';
import 'package:fintrack_app/screens/settings/pages/language_page.dart';
import 'package:fintrack_app/screens/settings/pages/notifications_page.dart';
import 'package:fintrack_app/screens/settings/pages/theme_page.dart';
import 'package:fintrack_app/screens/settings/pages/help_and_faq_page.dart';
import 'package:fintrack_app/screens/settings/pages/privacy_policy_page.dart';
import 'package:fintrack_app/screens/settings/pages/about_page.dart';
import 'package:fintrack_app/screens/settings/widgets/settings_item_widget.dart';
import 'package:fintrack_app/services/user_service.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _userService.addListener(_refresh);
  }

  @override
  void dispose() {
    _userService.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    
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
              Text(
                localizations.settings,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                localizations.manageYourPreferences,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20),
              SettingsItemWidget(
                icon: Icons.person,
                title: localizations.profile,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              SettingsItemWidget(
                icon: Icons.currency_exchange,
                title: localizations.currencyConverter,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CurrencyPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              SettingsItemWidget(
                icon: Icons.notifications_outlined,
                title: localizations.notifications,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationsPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              SettingsItemWidget(
                icon: Icons.language,
                title: localizations.language,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguagePage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              SettingsItemWidget(
                icon: Icons.brightness_6,
                title: localizations.theme,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ThemePage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              SettingsItemWidget(
                icon: Icons.help_outline,
                title: localizations.helpAndFAQ,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpAndFaqPage()
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              SettingsItemWidget(
                icon: Icons.privacy_tip_outlined,
                title: localizations.privacyPolicy,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyPage()
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              SettingsItemWidget(
                icon: Icons.info_outline,
                title: localizations.about,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutPage()
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              Center(
                child: Column(
                  children: [
                    const Text(
                      "Spendly",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      localizations.version,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ],
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
