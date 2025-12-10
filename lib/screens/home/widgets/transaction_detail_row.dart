import 'package:flutter/material.dart';

class TransactionDetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool showValueIcon;
  final IconData? valueIcon;

  const TransactionDetailRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.showValueIcon = false,
    this.valueIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 28,
          color: isDark ? Colors.grey.shade400 : Colors.black38,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? Colors.grey.shade400 : Colors.black54,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (showValueIcon && valueIcon != null) ...[
                    Icon(
                      valueIcon,
                      size: 24,
                      color: isDark ? Colors.white70 : Colors.black87,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
