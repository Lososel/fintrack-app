import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onAddTransaction;
  final VoidCallback onViewAll;

  const ActionButtons({
    super.key,
    required this.onAddTransaction,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onAddTransaction,
            icon: const Icon(Icons.add, color: Colors.white, size: 13),
            label: const Text(
              "Add Transaction",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff1e1e1e),
              padding: const EdgeInsets.symmetric(vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: OutlinedButton(
            onPressed: onViewAll,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20),
              side: const BorderSide(color: Colors.black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              "View all",
              style: TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
