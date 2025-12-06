import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/button/secondary_button.dart';
import 'package:fintrack_app/screens/auth/signup_screen.dart';
import 'package:fintrack_app/screens/auth/login_screen.dart';

class SignUpIntroScreen extends StatelessWidget {
  const SignUpIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/Vector-2.png",
                fit: BoxFit.cover,
                height: 150,
              ),
            ),

            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/Vector-2.png",
                fit: BoxFit.cover,
                height: 150,
              ),
            ),

            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Stay on top of your\nfinance with us.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Manage your daily expenses,\nincome and savings",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),

                    const SizedBox(height: 30),

                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        PrimaryButton(
                          label: "Create account",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const CreateAccountScreen(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        SecondaryButton(
                          label: "Login",
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
