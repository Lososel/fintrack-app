// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_settings.dart';
import 'screens/onboarding/start_screen.dart';
import 'services/language_service.dart';
import 'utils/app_localizations.dart';

void main() {
  runApp(const FinTrackApp());
}

class FinTrackApp extends StatefulWidget {
  const FinTrackApp({super.key});

  @override
  State<FinTrackApp> createState() => _FinTrackAppState();
}

class _FinTrackAppState extends State<FinTrackApp> {
  final LanguageService _languageService = LanguageService();

  // Global theme + text size state
  bool _isDarkMode = false;
  double _textScale = 1.0; // 1.0 = normal; will be changed in ThemePage

  @override
  void initState() {
    super.initState();
    _languageService.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    _languageService.removeListener(_onLanguageChanged);
    super.dispose();
  }

  void _onLanguageChanged() {
    setState(() {});
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF6F6F9),
      textTheme: GoogleFonts.dmSansTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      cardColor: Colors.white,
    );
  }

  ThemeData _buildDarkTheme() {
    final TextTheme darkTextTheme =
        GoogleFonts.dmSansTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF0D0D10),
      textTheme: darkTextTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF181820),
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      cardColor: const Color(0xFF181820),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppSettings(
      isDarkMode: _isDarkMode,
      textScale: _textScale,
      onThemeChanged: (value) {
        setState(() {
          _isDarkMode = value;
        });
      },
      onTextScaleChanged: (value) {
        setState(() {
          _textScale = value.clamp(0.8, 1.4);
        });
      },
      child: MaterialApp(
        title: 'Spendly',
        debugShowCheckedModeBanner: false,
        locale: _languageService.currentLocale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', ''), // English
          Locale('ru', ''), // Russian
          Locale('kk', ''), // Kazakh
        ],
        theme: _buildLightTheme(),
        darkTheme: _buildDarkTheme(),
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        // GLOBAL text scaling from ThemePage
        builder: (context, child) {
          final settings = AppSettings.of(context);
          final mediaQuery = MediaQuery.of(context);

          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaleFactor: settings.textScale,
            ),
            child: child ?? const SizedBox.shrink(),
          );
        },
        home: const StartScreen(),
      ),
    );
  }
}