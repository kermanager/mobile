import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_size.dart';

class SnackBarUtils {
  static void showCustomSnackBar(
      BuildContext context, String message, SnackBarVariant variant) {
    final Color backgroundColor;
    final IconData icon;

    switch (variant) {
      case SnackBarVariant.success:
        backgroundColor = ThemeColor.primary;
        icon = Icons.check_circle;
        break;
      case SnackBarVariant.error:
        backgroundColor = ThemeColor.red300;
        icon = Icons.error;
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: ThemeSize.s12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: backgroundColor,
      ),
    );
  }
}

enum SnackBarVariant { success, error }
