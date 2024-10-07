import 'package:flutter/material.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';

class LinkArrow extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final int? count;
  final bool? isRed;

  const LinkArrow({
    super.key,
    required this.label,
    required this.onTap,
    this.isRed = false,
    this.count,
  });

  @override
  State<LinkArrow> createState() => _LinkArrowState();
}

class _LinkArrowState extends State<LinkArrow> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ThemeSize.s12),
      child: Container(
        color: widget.isRed! ? ThemeColor.red100 : ThemeColor.gray100,
        child: InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(ThemeSize.s16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: ThemeFontSize.s16,
                    fontWeight: ThemeFontWeight.medium,
                    color: widget.isRed! ? ThemeColor.red200 : ThemeColor.black,
                  ),
                ),
                const Spacer(),
                widget.count != null
                    ? Text(
                        widget.count.toString(),
                        style: const TextStyle(
                          fontSize: ThemeFontSize.s14,
                          fontWeight: ThemeFontWeight.semiBold,
                          color: ThemeColor.gray400,
                        ),
                      )
                    : const SizedBox.shrink(),
                const SizedBox(width: ThemeSize.s16),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: ThemeFontSize.s16,
                  color: ThemeColor.gray300,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
