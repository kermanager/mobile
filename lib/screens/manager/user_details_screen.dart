import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_details_response.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/avatar.dart';
import 'package:kermanager/widgets/balance_label.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/link_arrow.dart';
import 'package:kermanager/widgets/role_label.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/sign_out_button.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  const UserDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final UserService _userService = UserService();

  Future<UserDetailsResponse> _get() async {
    ApiResponse<UserDetailsResponse> response = await _userService.details(
      userId: widget.userId,
    );
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text("Mon profil"),
      ),
      children: [
        DetailsFutureBuilder<UserDetailsResponse>(
          future: _get,
          builder: (context, data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BalanceLabel(balance: data.credit),
                  ],
                ),
                const SizedBox(height: ThemeSize.s8),
                const Avatar(),
                const SizedBox(height: ThemeSize.s16),
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: ThemeSize.s20,
                    fontWeight: ThemeFontWeight.medium,
                    color: ThemeColor.black,
                  ),
                ),
                const SizedBox(height: ThemeSize.s8),
                RoleLabel(role: data.role),
                const SizedBox(height: ThemeSize.s8),
                Text(
                  data.email,
                  style: const TextStyle(
                    fontSize: ThemeSize.s16,
                    fontWeight: ThemeFontWeight.regular,
                    color: ThemeColor.gray400,
                  ),
                ),
                const SizedBox(height: ThemeSize.s36),
                Column(
                  children: [
                    LinkArrow(
                      label: "Changer le mot de passe",
                      onTap: () {
                        context.push(
                          ManagerRoutes.userEdit,
                        );
                      },
                    ),
                    const SizedBox(height: ThemeSize.s8),
                    const SignOutButton(),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
