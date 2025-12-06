import 'package:fintrack_app/components/button/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/fields/input_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 40),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back, size: 26),
                ),
              ),


              const Center(
                child: Column(
                  children: [
                    Text(
                      "Create an account",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Manage your money wisely",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),


              InputField(hint: "Full name"),
              const SizedBox(height: 16),
              InputField(hint: "Email address"),
              const SizedBox(height: 16),
              InputField(hint: "Password", isPassword: true),
              const SizedBox(height: 32),


              Center(
                child: PrimaryButton(label: "Create account", onPressed: () {}),
              ),

              const SizedBox(height: 28),


              Center(
                child: SecondaryButton(
                  label: "Already have an account?",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
