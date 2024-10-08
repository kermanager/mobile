import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/router/child/routes.dart';
import 'package:kermanager/router/parent/routes.dart';
import 'package:kermanager/router/stand_holder/routes.dart';
import 'package:kermanager/theme/theme_color.dart';
import 'package:kermanager/theme/theme_font.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/link_button.dart';
import 'package:kermanager/widgets/password_form_input.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_form_input.dart';
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
  final _formKey = GlobalKey<FormState>();

  final AuthService _authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
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
          context.go(StandHolderRoutes.standDetails);
        } else if (response.data!.role == "PARENT") {
          context.go(ParentRoutes.kermesseList);
        } else if (response.data!.role == "CHILD") {
          context.go(ChildRoutes.kermesseList);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Connexion réussie'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text('Se connecter'),
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
              label: "Se connecter",
              onTap: _submit,
            ),
          ],
        ),
        const SizedBox(height: ThemeSize.s36),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Pas encore inscrit ?",
              style: TextStyle(
                fontSize: ThemeFontSize.s16,
                fontWeight: ThemeFontWeight.regular,
                color: ThemeColor.gray300,
              ),
            ),
            const SizedBox(width: ThemeSize.s8),
            LinkButton(
              label: "Inscrivez-vous",
              onTap: () {
                context.push(AuthRoutes.signUp);
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
