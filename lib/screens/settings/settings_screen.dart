import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/screens/settings/profile_page.dart';
import 'package:fintrack_app/screens/settings/currency_page.dart';
import 'package:fintrack_app/screens/settings/language_page.dart';
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
              _SettingsItem(
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
              _SettingsItem(
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
              _SettingsItem(
                icon: Icons.notifications_outlined,
                title: localizations.notifications,
                onTap: () {
                  // TODO: Navigate to notifications screen
                },
              ),
              const SizedBox(height: 8),
              _SettingsItem(
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
              _SettingsItem(
                icon: Icons.brightness_6,
                title: localizations.theme,
                onTap: () {
                  // TODO: Navigate to theme settings screen
                },
              ),
              const SizedBox(height: 8),
              _SettingsItem(
                icon: Icons.help_outline,
                title: localizations.helpAndFAQ,
                onTap: () {
                  // TODO: Navigate to help and FAQ screen
                },
              ),
              const SizedBox(height: 8),
              _SettingsItem(
                icon: Icons.privacy_tip_outlined,
                title: localizations.privacyPolicy,
                onTap: () {
                  // TODO: Navigate to privacy policy screen
                },
              ),
              const SizedBox(height: 8),
              _SettingsItem(
                icon: Icons.info_outline,
                title: localizations.about,
                onTap: () {
                  // TODO: Navigate to about screen
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

class _SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: Colors.grey.shade700,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: Colors.grey.shade600,
            ),
          ],
        ),
      ),
    );
  }
}
