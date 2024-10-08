import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class NoResultCard extends StatefulWidget {
  final String message;

  const NoResultCard({
    super.key,
    required this.message,
  });

  @override
  State<NoResultCard> createState() => _NoResultCardState();
}

class _NoResultCardState extends State<NoResultCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      padding: const EdgeInsets.only(bottom: 100),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_off,
            size: 200,
            color: ThemeColor.gray200,
          ),
          const SizedBox(height: ThemeSize.s16),
          Text(
            widget.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: ThemeFontSize.s16,
              color: ThemeColor.gray400,
            ),
          ),
        ],
      ),
    );
  }
}
