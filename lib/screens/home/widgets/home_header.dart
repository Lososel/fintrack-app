import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String name;
  const HomeHeader({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Good morning, $name.",
      style: TextStyle(fontSize: 34, fontWeight: FontWeight.w800),
    );
  }
}
