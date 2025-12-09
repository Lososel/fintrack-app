import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/button/secondary_button.dart';
import 'package:fintrack_app/components/fields/input_field.dart';
import 'package:fintrack_app/components/arrow/back_arrow.dart';
import 'package:fintrack_app/screens/auth/login_screen.dart';
import 'package:fintrack_app/screens/home/homepage_screen.dart';
import 'package:fintrack_app/services/user_service.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class CreateAccountScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  CreateAccountScreen({super.key});

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
              const SizedBox(height: 90),

              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        localizations.createAnAccount,
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

                      InputField(hint: localizations.fullName, controller: nameController),
                      const SizedBox(height: 16),

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
                        label: localizations.createAccount,
                        onPressed: () {
                          final userName = nameController.text.trim();
                          final userEmail = emailController.text.trim();

                          // Store user data in service
                          UserService().setUser(userName, userEmail);

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(name: userName),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 28),

                      SecondaryButton(
                        label: localizations.alreadyHaveAnAccount,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
