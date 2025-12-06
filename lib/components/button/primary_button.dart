import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double borderRadius;
  final double verticalPadding;
  final TextStyle? textStyle;
  final Color backgroundColor;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.borderRadius = 23,
    this.verticalPadding = 30,
    this.textStyle,
    this.backgroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          label,
          style:
              textStyle ??
              const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
