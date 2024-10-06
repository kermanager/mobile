import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/router/child/routes.dart';
import 'package:kermanager/router/parent/routes.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/widgets/password_input.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/providers/auth_provider.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/auth_service.dart';
import 'package:kermanager/data/sign_in_response.dart';
import 'package:kermanager/router/auth/routes.dart';
import 'package:kermanager/api/api_constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submit() async {
    ApiResponse<SignInResponse> response = await _authService.signIn(
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
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString(
        ApiConstants.tokenKey,
        response.data!.token,
      );
      Provider.of<AuthProvider>(context, listen: false).setUser(
        response.data!.id,
        response.data!.name,
        response.data!.email,
        response.data!.role,
        response.data!.hasStand,
      );
      if (response.data!.role == "MANAGER") {
        context.go(ManagerRoutes.kermesseList);
      } else if (response.data!.role == "STAND_HOLDER") {
        context.go(StandHolderRoutes.kermesseList);
      } else if (response.data!.role == "PARENT") {
        context.go(ParentRoutes.kermesseList);
      } else if (response.data!.role == "CHILD") {
        context.go(ChildRoutes.kermesseList);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Sign in successful'),
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
              'Sign In',
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            PasswordInput(
              hintText: "Password",
              controller: _passwordController,
            ),
            ElevatedButton(
              onPressed: _submit,
              child: const Text(
                'Sign In',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AuthRoutes.signUp);
              },
              child: const Text(
                'Sign Up',
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
