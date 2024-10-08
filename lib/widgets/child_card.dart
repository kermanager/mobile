import 'package:flutter/material.dart';
import 'package:kermanager/data/user_list_response.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/icon_box.dart';

class ChildCard extends StatefulWidget {
  final UserListItem user;
  final VoidCallback onTap;

  const ChildCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  State<ChildCard> createState() => _ChildCardState();
}

class _ChildCardState extends State<ChildCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeSize.s12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const IconBox(
                icon: Icons.face,
                isLarge: true,
              ),
              const SizedBox(width: ThemeSize.s16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.user.name,
                    style: const TextStyle(
                      fontSize: ThemeFontSize.s16,
                      fontWeight: ThemeFontWeight.medium,
                      color: ThemeColor.black,
                    ),
                  ),
                  const SizedBox(height: ThemeSize.s4),
                  Text(
                    widget.user.email,
                    style: const TextStyle(
                      fontSize: ThemeFontSize.s12,
                      fontWeight: ThemeFontWeight.regular,
                      color: ThemeColor.gray400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_forward_ios,
                size: ThemeSize.s16,
                color: ThemeColor.gray300,
              ),
            ],
          ),
        ),
        const SizedBox(height: ThemeSize.s16),
      ],
    );
  }
}
