import 'package:flutter/material.dart';
import 'package:fintrack_app/app_settings.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/screens/settings/widgets/theme_option_widget.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final appSettings = AppSettings.of(context);
    final isDarkMode = appSettings.isDarkMode;
    final textScale = appSettings.textScale;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final backgroundColor = isDarkMode ? const Color(0xFF0D0D10) : const Color(0xffF6F6F9);
    final cardColor = isDarkMode ? const Color(0xFF181820) : Colors.white;
    final iconColor = isDarkMode ? Colors.white : Colors.black;

    return Scaffold(
      backgroundColor: backgroundColor,
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
                  Expanded(
                    child: Text(
                      localizations.theme,
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
              const SizedBox(height: 24),
              // Light Mode Option
              ThemeOptionWidget(
                title: localizations.lightMode,
                description: localizations.brightAndCleanInterface,
                icon: Icons.wb_sunny,
                isSelected: !isDarkMode,
                onTap: () {
                  appSettings.onThemeChanged(false);
                },
              ),
              const SizedBox(height: 12),
              // Dark Mode Option
              ThemeOptionWidget(
                title: localizations.darkMode,
                description: localizations.easyOnTheEyes,
                icon: Icons.dark_mode,
                isSelected: isDarkMode,
                onTap: () {
                  appSettings.onThemeChanged(true);
                },
              ),
              const SizedBox(height: 32),
              // Text Size Section
              Text(
                localizations.textSize,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                localizations.adjustFontSize,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              // Text Size Slider
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Slider(
                      value: textScale,
                      min: 0.8,
                      max: 1.4,
                      divisions: 6,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey.shade300,
                      onChanged: (value) {
                        appSettings.onTextScaleChanged(value);
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localizations.small,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          localizations.large,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
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

