import 'package:flutter/material.dart';
import 'package:kermanager/data/user_list_response.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button_icon.dart';
import 'package:kermanager/widgets/icon_box.dart';

class ChildInviteCard extends StatefulWidget {
  final UserListItem user;
  final VoidCallback onTap;

  const ChildInviteCard({
    super.key,
    required this.user,
    required this.onTap,
  });

  @override
  State<ChildInviteCard> createState() => _ChildInviteCardState();
}

class _ChildInviteCardState extends State<ChildInviteCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
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
            ButtonIcon(
              icon: Icons.send,
              onTap: widget.onTap,
            ),
          ],
        ),
        const SizedBox(height: ThemeSize.s16),
      ],
    );
  }
}
