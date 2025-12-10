import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _openGitHubLink(BuildContext context) async {
    final url = Uri.parse('https://github.com/Lososel/fintrack-app');
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Handle error if URL cannot be launched
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open GitHub link'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.grey.shade400 : Colors.black54;

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
                      localizations.about,
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
              const SizedBox(height: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    localizations.personalFinanceManager,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localizations.version,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: secondaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    localizations.aboutDescription,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: secondaryTextColor,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 60),
                  Text(
                    localizations.madeWithLove,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () => _openGitHubLink(context),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          localizations.github,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.open_in_new,
                          size: 20,
                          color: textColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

