import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Alignment alignment;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.textStyle,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: GestureDetector(
        onTap: onPressed,
        child: Text(
          label,
          style:
              textStyle ??
              const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
        ),
      ),
    );
  }
}
