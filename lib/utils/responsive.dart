import 'package:flutter/material.dart';

const double baseWidth = 375.0;

// Responsive size based on screen width.
double rs(BuildContext context, double base) {
  final width = MediaQuery.of(context).size.width;
  return base * (width / baseWidth);
}
