import 'package:flutter/material.dart';

class BackArrow extends StatelessWidget {
  final VoidCallback? onTap;
  final double size;
  final Color color;
  final EdgeInsets padding;

  const BackArrow({
    super.key,
    this.onTap,
    this.size = 26,
    this.color = Colors.black,
    this.padding = const EdgeInsets.only(top: 33, left: 0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: onTap ?? () => Navigator.pop(context),
        child: Icon(Icons.arrow_back_ios, size: size, color: color),
      ),
    );
  }
}
