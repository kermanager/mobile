import 'package:flutter/material.dart';
import 'package:kermanager/data/user_list_response.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/icon_box.dart';
import 'package:kermanager/widgets/role_label.dart';

class ParticipantCard extends StatefulWidget {
  final UserListItem user;

  const ParticipantCard({
    super.key,
    required this.user,
  });

  @override
  State<ParticipantCard> createState() => _ParticipantCardState();
}

class _ParticipantCardState extends State<ParticipantCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
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
                  RoleLabel(role: widget.user.role),
                ],
              ),
              const Spacer(),
              Text(
                "${widget.user.points.toString()} point",
                style: const TextStyle(
                  fontSize: ThemeFontSize.s18,
                  fontWeight: ThemeFontWeight.semiBold,
                  color: ThemeColor.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: ThemeSize.s16),
      ],
    );
  }
}
