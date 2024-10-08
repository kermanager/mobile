import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_constants.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/providers/auth_provider.dart';
import 'package:kermanager/router/auth/routes.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/password_form_input.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserEditScreen extends StatefulWidget {
  final int userId;

  const UserEditScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final UserService _userService = UserService();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _userService.edit(
        userId: widget.userId,
        password: _passwordController.text,
        newPassword: _newPasswordController.text,
      );
      if (response.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.error!),
          ),
        );
      } else {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove(ApiConstants.tokenKey);
        Provider.of<AuthProvider>(context, listen: false)
            .setUser(-1, "", "", "", false);
        context.go(AuthRoutes.signIn);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password edited successfully'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Modifier le mot de passe'),
      ),
      children: [
        FormColumn(
          formKey: _formKey,
          children: [
            PasswordFormInput(
              hintText: "Mot de passe",
              controller: _passwordController,
            ),
            const SizedBox(height: ThemeSize.s16),
            PasswordFormInput(
              hintText: "Nouveau mot de passe",
              controller: _newPasswordController,
            ),
            const SizedBox(height: ThemeSize.s16),
            Button(
              onTap: _submit,
              label: "Modifier",
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }
}
