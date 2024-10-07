import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class RoleLabel extends StatefulWidget {
  final String role;

  const RoleLabel({super.key, required this.role});

  @override
  State<RoleLabel> createState() => _RoleLabelState();
}

class _RoleLabelState extends State<RoleLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColor.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: ThemeSize.s12,
        vertical: ThemeSize.s4,
      ),
      child: Text(
        widget.role == 'MANAGER'
            ? 'Organisateur'
            : widget.role == 'CHILD'
                ? 'Enfant'
                : widget.role == 'PARENT'
                    ? 'Parent'
                    : 'Teneur de stand',
        style: const TextStyle(
          fontSize: ThemeFontSize.s12,
          fontWeight: ThemeFontWeight.medium,
          color: ThemeColor.white,
        ),
      ),
    );
  }
}
