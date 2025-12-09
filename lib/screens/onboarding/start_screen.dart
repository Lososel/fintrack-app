import 'package:flutter/material.dart';
import '../../../utils/responsive.dart';
import '../../../utils/app_localizations.dart';
import 'dart:async';
import 'welcome_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after 5 seconds
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => const SignUpIntroScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/start.jpg'),
              fit: BoxFit.cover,
              alignment: Alignment.center,
              colorFilter: ColorFilter.mode(
                Color.fromRGBO(0, 0, 0, 0.2),
                BlendMode.darken,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, top: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Spendly',
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    localizations.yourPersonalFinanceManager,
                    style: TextStyle(
                      fontSize: rs(context, 28),
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
