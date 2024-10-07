import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:kermanager/services/auth_service.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/form.dart';
import 'package:kermanager/widgets/password_form_input.dart';
import 'package:kermanager/widgets/role_select.dart';
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
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.errorMessage),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sign up successful'),
          ),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                const SizedBox(height: ThemeSize.s16),
                Button(
                  label: 'S\'inscrire',
                  onTap: _submit,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                'Sign In',
              ),
            )
          ],
        ),
      ),
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
