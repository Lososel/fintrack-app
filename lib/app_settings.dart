// lib/app_settings.dart
import 'package:flutter/material.dart';

/// Global app settings: dark mode + text scale.
/// Wraps MaterialApp in main.dart and is accessible
/// from any page via AppSettings.of(context).
class AppSettings extends InheritedWidget {
  final bool isDarkMode;
  final double textScale;
  final ValueChanged<bool> onThemeChanged;
  final ValueChanged<double> onTextScaleChanged;

  const AppSettings({
    super.key,
    required this.isDarkMode,
    required this.textScale,
    required this.onThemeChanged,
    required this.onTextScaleChanged,
    required Widget child,
  }) : super(child: child);

  static AppSettings of(BuildContext context) {
    final AppSettings? result =
        context.dependOnInheritedWidgetOfExactType<AppSettings>();
    assert(result != null, 'No AppSettings found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant AppSettings oldWidget) {
    return isDarkMode != oldWidget.isDarkMode ||
        textScale != oldWidget.textScale;
  }
}