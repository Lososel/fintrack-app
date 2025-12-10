import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/button/secondary_button.dart';
import 'package:fintrack_app/components/arrow/back_arrow.dart';
import 'package:fintrack_app/screens/auth/signup_screen.dart';
import 'package:fintrack_app/screens/home/homepage_screen.dart';
import 'package:fintrack_app/services/user_service.dart';
import 'package:fintrack_app/utils/app_localizations.dart';
import 'package:fintrack_app/utils/validation_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  // Example: placeholder for actual auth
  Future<String> _performLogin(String email, String password) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      // TODO: replace with real auth API call
      // For now, simulate authentication
      // In real app, this would call: await authService.login(email, password);
      
      // Simulate checking stored credentials (in real app, this would be from backend)
      // For demo purposes, accept any email/password combination
      // In production, validate against backend
      
      // Example fallback: take part before @ as name
      final name = email.split('@').first;
      return name.isNotEmpty ? _capitalize(name) : 'User';
    } catch (e) {
      // Handle different types of errors
      if (e.toString().contains('network') || e.toString().contains('connection')) {
        throw Exception('Network error. Please check your internet connection.');
      } else if (e.toString().contains('invalid') || e.toString().contains('credentials')) {
        throw Exception('Invalid email or password. Please try again.');
      } else {
        throw Exception('Login failed. Please try again later.');
      }
    }
  }

  String _capitalize(String s) {
    if (s.isEmpty) return s;
    return s[0].toUpperCase() + s.substring(1);
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final email = emailController.text.trim();
      final password = passwordController.text;

      final userName = await _performLogin(email, password);

      // Store user data in service
      UserService().setUser(userName, email);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(name: userName),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
        _isLoading = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage ?? 'Login failed. Please try again.'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

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

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // Email field with validation
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: localizations.emailAddress,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                            ),
                            validator: (value) => ValidationHelper.validateEmail(value),
                            onChanged: (_) {
                              setState(() {
                                _errorMessage = null;
                              });
                            },
                          ),
                          const SizedBox(height: 16),
                          // Password field with validation
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: localizations.password,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                            ),
                            validator: (value) =>
                                ValidationHelper.validatePasswordForLogin(value),
                            onChanged: (_) {
                              setState(() {
                                _errorMessage = null;
                              });
                            },
                            onFieldSubmitted: (_) => _handleLogin(),
                          ),
                          if (_errorMessage != null) ...[
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.red.shade200),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.error_outline,
                                      color: Colors.red.shade700, size: 20),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      _errorMessage!,
                                      style: TextStyle(
                                        color: Colors.red.shade700,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 32),
                          PrimaryButton(
                            label: _isLoading ? 'Loading...' : localizations.login,
                            onPressed: _isLoading
                                ? () {}
                                : () {
                                    _handleLogin();
                                  },
                          ),
                        ],
                      ),
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
