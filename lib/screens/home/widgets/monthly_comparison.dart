import 'package:flutter/material.dart';

class MonthlyComparison extends StatelessWidget {
  const MonthlyComparison({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Monthly Comparison",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 16),
        Container(
          height: 180,
          color: const Color.fromARGB(255, 238, 238, 238),
          child: const Center(child: Text("Bar Chart Here")),
        ),
      ],
    );
  }
}
