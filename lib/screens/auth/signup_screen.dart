import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/components/button/secondary_button.dart';
import 'package:fintrack_app/components/arrow/back_arrow.dart';
import 'package:fintrack_app/screens/auth/login_screen.dart';
import 'package:fintrack_app/screens/home/homepage_screen.dart';
import 'package:fintrack_app/services/user_service.dart';
import 'package:fintrack_app/utils/app_localizations.dart';
import 'package:fintrack_app/utils/validation_helper.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  PasswordStrength _passwordStrength = PasswordStrength.none;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength(String password) {
    setState(() {
      _passwordStrength = ValidationHelper.getPasswordStrength(password);
    });
  }

  Color _getPasswordStrengthColor() {
    switch (_passwordStrength) {
      case PasswordStrength.none:
        return Colors.grey;
      case PasswordStrength.weak:
        return Colors.red;
      case PasswordStrength.medium:
        return Colors.orange;
      case PasswordStrength.strong:
        return Colors.green;
    }
  }

  String _getPasswordStrengthText() {
    switch (_passwordStrength) {
      case PasswordStrength.none:
        return '';
      case PasswordStrength.weak:
        return 'Weak password';
      case PasswordStrength.medium:
        return 'Medium strength';
      case PasswordStrength.strong:
        return 'Strong password';
    }
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userName = nameController.text.trim();
      final userEmail = emailController.text.trim();

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 800));

      // TODO: Replace with real signup API call
      // await authService.signup(userName, userEmail, passwordController.text);

      // Store user data in service
      UserService().setUser(userName, userEmail);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(name: userName),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().replaceFirst('Exception: ', ''),
            ),
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

                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Name field
                            TextFormField(
                              controller: nameController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: localizations.fullName,
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
                                  ValidationHelper.validateName(value),
                            ),
                            const SizedBox(height: 16),

                            // Email field
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
                              validator: (value) =>
                                  ValidationHelper.validateEmail(value),
                            ),
                            const SizedBox(height: 16),

                            // Password field
                            TextFormField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              textInputAction: TextInputAction.next,
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
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) =>
                                  ValidationHelper.validatePassword(value),
                              onChanged: _checkPasswordStrength,
                            ),
                            if (_passwordStrength != PasswordStrength.none) ...[
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: _passwordStrength ==
                                              PasswordStrength.weak
                                          ? 0.33
                                          : _passwordStrength ==
                                                  PasswordStrength.medium
                                              ? 0.66
                                              : 1.0,
                                      backgroundColor: Colors.grey.shade300,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        _getPasswordStrengthColor(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _getPasswordStrengthText(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _getPasswordStrengthColor(),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            const SizedBox(height: 16),

                            // Confirm Password field
                            TextFormField(
                              controller: confirmPasswordController,
                              obscureText: _obscureConfirmPassword,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: 'Confirm Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade100,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 18,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmPassword
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureConfirmPassword =
                                          !_obscureConfirmPassword;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please confirm your password';
                                }
                                if (value != passwordController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                              onFieldSubmitted: (_) => _handleSignup(),
                            ),
                            const SizedBox(height: 32),

                            PrimaryButton(
                              label: _isLoading
                                  ? 'Creating...'
                                  : localizations.createAccount,
                              onPressed: _isLoading
                                  ? () {}
                                  : () {
                                      _handleSignup();
                                    },
                            ),
                          ],
                        ),
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
