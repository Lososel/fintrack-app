import 'package:flutter/material.dart';

class AppModal extends StatelessWidget {
  final String title;
  final Widget child;

  const AppModal({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xffF4F4F7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),

          child,
        ],
      ),
    );
  }
}
