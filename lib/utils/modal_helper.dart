import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/smooth_modal_route.dart';

class ModalHelper {
  static Future<T?> showSmoothModal<T>({
    required BuildContext context,
    required Widget child,
  }) {
    return Navigator.of(context).push<T>(
      SmoothModalRoute<T>(
        builder: (_) => child,
        barrierColor: Colors.black.withOpacity(0.5),
        isDismissible: true,
        enableDrag: true,
      ),
    );
  }
}
