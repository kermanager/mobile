import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_details_response.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/avatar.dart';
import 'package:kermanager/widgets/balance_label.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/number_form_input.dart';
import 'package:kermanager/widgets/role_label.dart';
import 'package:kermanager/widgets/screen.dart';

class ChildrenDetailsScreen extends StatefulWidget {
  final int userId;

  const ChildrenDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<ChildrenDetailsScreen> createState() => _ChildrenDetailsScreenState();
}

class _ChildrenDetailsScreenState extends State<ChildrenDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  final UserService _userService = UserService();

  final TextEditingController _amountController = TextEditingController();

  Future<UserDetailsResponse> _get() async {
    ApiResponse<UserDetailsResponse> response = await _userService.details(
      userId: widget.userId,
    );
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  Future<void> _send() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _userService.sendCredit(
        childId: widget.userId,
        amount: int.parse(_amountController.text),
      );
      if (response.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Jetons envoyés avec succès'),
          ),
        );
        _refresh();
      }
    }
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(),
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
                FormColumn(
                  formKey: _formKey,
                  children: [
                    NumberFormInput(
                      hintText: "Nombre de jetons",
                      controller: _amountController,
                      unit: "jeton",
                    ),
                    const SizedBox(height: ThemeSize.s16),
                    Button(
                      onTap: _send,
                      label: "Envoyer les jetons",
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
