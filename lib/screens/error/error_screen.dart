import 'package:flutter/material.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class ErrorScreen extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRetry;
  final bool isNoConnection;

  const ErrorScreen({
    super.key,
    this.title,
    this.message,
    this.onRetry,
    this.isNoConnection = false,
  });

  @override
  Widget build(BuildContext context) {
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final errorTitle = title ??
        (isNoConnection
            ? localizations.noConnectionTitle
            : localizations.errorTitle);
    final errorMessage = message ??
        (isNoConnection
            ? localizations.noConnectionMessage
            : localizations.errorMessage);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Error Icon
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.red.withOpacity(0.1)
                        : Colors.red.withOpacity(0.05),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isNoConnection ? Icons.wifi_off : Icons.error_outline,
                    size: 64,
                    color: isDark ? Colors.red.shade300 : Colors.red.shade600,
                  ),
                ),
                const SizedBox(height: 32),

                // Error Title
                Text(
                  errorTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Error Message
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 48),

                // Retry Button
                if (onRetry != null)
                  PrimaryButton(
                    label: localizations.retry,
                    onPressed: onRetry!,
                    verticalPadding: 18,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

