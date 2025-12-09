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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 28,
          color: Colors.black38,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
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
                      color: Colors.black87,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
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

