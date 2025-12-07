import 'package:flutter/material.dart';

class SpendingOverview extends StatelessWidget {
  const SpendingOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Spending Overview",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            Text(
              "View Details →",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // PIE CHART PLACEHOLDER (we add real chart next)
        Center(
          child: Container(
            width: 180,
            height: 180,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(255, 238, 238, 238),
            ),
            child: const Center(child: Text("Pie Chart Here")),
          ),
        ),

        const SizedBox(height: 20),

        const Text("• Travel"),
        const Text("• Food & Dining"),
        const Text("• Shopping"),
        const Text("• Utilities"),
      ],
    );
  }
}
