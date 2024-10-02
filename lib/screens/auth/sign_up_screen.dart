import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:kermanager/services/auth_service.dart';
import 'package:kermanager/api/api_response.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> _submit() async {
    ApiResponse<Null> response = await _authService.signUp(
      role: _roleController.text,
      name: _nameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (response.error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.error!),
        ),
      );
    } else {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign up successful'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text(
              'Sign Up',
            ),
            TextField(
              controller: _roleController,
              decoration: const InputDecoration(
                hintText: 'Role',
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
              ),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            ElevatedButton(
              onPressed: _submit,
              child: const Text(
                'Sign Up',
              ),
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
    _roleController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
