import 'package:flutter/material.dart';

class CategoryColors {
  static const Map<String, Color> colors = {
    "Travel": Color(0xFF3B82F6), // Blue
    "Dining": Color(0xFFEF4444), // Red
    "Food & Dining": Color(0xFFEF4444), // Red (alternative name)
    "Groceries": Color(0xFF10B981), // Green
    "Utilities": Color(0xFFEC4899), // Pink
    "Shopping": Color(0xFFF59E0B), // Orange
    "Entertainment": Color(0xFF8B5CF6), // Purple
    "Health": Color(0xFF06B6D4), // Cyan
    "Salary": Color(0xFF84CC16), // Lime
    "Other": Color(0xFF6B7280), // Gray
  };

  static Color getColor(String category) {
    return colors[category] ?? colors["Other"]!;
  }

  static List<Color> getColorList(List<String> categories) {
    return categories.map((cat) => getColor(cat)).toList();
  }
}
