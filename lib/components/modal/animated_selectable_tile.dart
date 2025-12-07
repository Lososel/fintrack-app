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
          color: isPressed ? Colors.grey.shade200 : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            if (widget.icon != null)
              Icon(widget.icon, size: 22, color: Colors.black87),
            if (widget.icon != null) const SizedBox(width: 16),

            Text(
              widget.title,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
