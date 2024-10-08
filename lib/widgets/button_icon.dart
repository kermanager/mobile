import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_size.dart';

class ButtonIcon extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const ButtonIcon({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  State<ButtonIcon> createState() => _ButtonIconState();
}

class _ButtonIconState extends State<ButtonIcon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ThemeSize.s56,
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ButtonStyle(
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(
              vertical: ThemeSize.s18,
            ),
          ),
          backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.pressed)) {
              return ThemeColor.secondary;
            }
            return ThemeColor.primary;
          }),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ThemeSize.s12),
            ),
          ),
        ),
        child: Icon(
          widget.icon,
          size: ThemeSize.s20,
          color: ThemeColor.white,
        ),
      ),
    );
  }
}
