import 'package:flutter/material.dart';

class AnimatedSelectableTile extends StatefulWidget {
  final String title;
  final IconData? icon;
  final VoidCallback onTap;

  const AnimatedSelectableTile({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
  });

  @override
  State<AnimatedSelectableTile> createState() => _AnimatedSelectableTileState();
}

class _AnimatedSelectableTileState extends State<AnimatedSelectableTile> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return GestureDetector(
      onTapDown: (_) => setState(() => isPressed = true),
      onTapCancel: () => setState(() => isPressed = false),
      onTapUp: (_) => setState(() => isPressed = false),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 140),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: isPressed
              ? (isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade200)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (widget.icon != null)
              Icon(
                widget.icon,
                size: 22,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            if (widget.icon != null) const SizedBox(width: 16),

            Text(
              widget.title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
