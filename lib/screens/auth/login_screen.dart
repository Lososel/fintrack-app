import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/button/secondary_button.dart';
import 'package:fintrack_app/components/fields/input_field.dart';
import 'package:fintrack_app/components/arrow/back_arrow.dart';
import 'package:fintrack_app/screens/auth/signup_screen.dart';
import 'package:fintrack_app/screens/home/homepage_screen.dart';
import 'package:fintrack_app/services/user_service.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Example: placeholder for actual auth
  Future<String> _performLogin(String email, String password) async {
    // TODO: replace with real auth and fetch user profile/name
    await Future.delayed(const Duration(milliseconds: 400));
    // Example fallback: take part before @ as name
    final name = email.split('@').first;
    return name.isNotEmpty ? _capitalize(name) : 'User';
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BackArrow(),
              const SizedBox(height: 130),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      localizations.login,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localizations.manageYourMoneyWisely,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Use InputField with controller (ensure your InputField accepts controller)
                    InputField(
                      hint: localizations.emailAddress,
                      controller: emailController,
                    ),
                    const SizedBox(height: 16),
                    InputField(
                      hint: localizations.password,
                      isPassword: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 32),

                    PrimaryButton(
                      label: localizations.login,
                      onPressed: () async {
                        final email = emailController.text.trim();
                        final password = passwordController.text;
                        // simple validation
                        if (email.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(localizations.pleaseEnterEmailAndPassword),
                            ),
                          );
                          return;
                        }

                        // perform login & get a name (replace this with real auth)
                        final userName = await _performLogin(email, password);
                        
                        // Store user data in service
                        UserService().setUser(userName, email);

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(name: userName),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 28),

                    SecondaryButton(
                      label: localizations.createAccount,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateAccountScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
