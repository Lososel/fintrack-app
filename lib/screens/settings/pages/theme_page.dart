// lib/screens/settings/pages/theme_page.dart
import 'package:flutter/material.dart';
import 'package:fintrack_app/app_settings.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = AppSettings.of(context);
    final isDark = settings.isDarkMode;
    final textSize = settings.textScale;

    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Theme'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Appearance
              Text(
                'Appearance',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              _ThemeOptionCard(
                icon: Icons.wb_sunny_outlined,
                title: 'Light Mode',
                subtitle: 'Bright and clean interface',
                selected: !isDark,
                onTap: () => settings.onThemeChanged(false),
              ),
              const SizedBox(height: 12),
              _ThemeOptionCard(
                icon: Icons.nightlight_round_outlined,
                title: 'Dark Mode',
                subtitle: 'Easy on the eyes',
                selected: isDark,
                onTap: () => settings.onThemeChanged(true),
              ),
              const SizedBox(height: 28),

              // Text size
              Text(
                'Text size',
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Adjust font size',
                style: TextStyle(
                  fontSize: 13,
                  color: textColor.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 20),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 8),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 16),
                ),
                child: Slider(
                  value: textSize,
                  min: 0.8,
                  max: 1.4,
                  onChanged: (value) {
                    settings.onTextScaleChanged(value);
                  },
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Small',
                    style: TextStyle(
                      fontSize: 13,
                      color: textColor.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    'Medium',
                    style: TextStyle(
                      fontSize: 13,
                      color: textColor.withOpacity(0.6),
                    ),
                  ),
                  Text(
                    'Large',
                    style: TextStyle(
                      fontSize: 13,
                      color: textColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Preview
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  'This is how your text will look.',
                  style: TextStyle(
                    fontSize: 14 * textSize,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeOptionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        selected ? Colors.blueAccent : Colors.grey.withOpacity(0.25);
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.2),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24,
              color: textColor,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: textColor.withOpacity(0.6),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              const Icon(
                Icons.check_circle,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }
}