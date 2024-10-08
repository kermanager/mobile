import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:kermanager/services/auth_service.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/utils/snackbar.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/link_button.dart';
import 'package:kermanager/widgets/password_form_input.dart';
import 'package:kermanager/widgets/role_select.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_form_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  String _selectedRole = 'MANAGER';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _authService.signUp(
        role: _selectedRole,
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (response.error != null) {
        SnackBarUtils.showCustomSnackBar(
          context,
          response.error!,
          SnackBarVariant.error,
        );
      } else {
        context.pop();
        SnackBarUtils.showCustomSnackBar(
          context,
          'Inscription réussie',
          SnackBarVariant.success,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text("S'inscrire"),
      ),
      withoutBottomBar: true,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.celebration_rounded,
              size: 100,
              color: ThemeColor.primary,
            ),
          ],
        ),
        const SizedBox(height: ThemeSize.s24),
        FormColumn(
          formKey: _formKey,
          children: [
            RoleSelect(
              defaultValue: _selectedRole,
              onChange: (value) {
                setState(() {
                  _selectedRole = value;
                });
              },
            ),
            const SizedBox(height: ThemeSize.s16),
            TextFormInput(
              hintText: "Nom complet",
              controller: _nameController,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: ThemeSize.s16),
            TextFormInput(
              hintText: "Email",
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: ThemeSize.s16),
            PasswordFormInput(
              hintText: "Mot de passe",
              controller: _passwordController,
            ),
            const SizedBox(height: ThemeSize.s24),
            Button(
              label: "S'inscrire",
              onTap: _submit,
            ),
          ],
        ),
        const SizedBox(height: ThemeSize.s36),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Déjà inscrit ?",
              style: TextStyle(
                fontSize: ThemeFontSize.s16,
                fontWeight: ThemeFontWeight.regular,
                color: ThemeColor.gray300,
              ),
            ),
            const SizedBox(width: ThemeSize.s8),
            LinkButton(
              label: "Connectez-vous",
              onTap: () {
                context.pop();
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
