import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/utils/snackbar.dart';
import 'package:kermanager/widgets/link_arrow.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:kermanager/router/auth/routes.dart';
import 'package:kermanager/providers/auth_provider.dart';
import 'package:kermanager/api/api_constants.dart';

class SignOutButton extends StatefulWidget {
  const SignOutButton({super.key});

  @override
  State<SignOutButton> createState() => _SignOutButtonState();
}

class _SignOutButtonState extends State<SignOutButton> {
  Future<void> _signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(ApiConstants.tokenKey);
    Provider.of<AuthProvider>(context, listen: false)
        .setUser(-1, "", "", "", false);
    context.go(AuthRoutes.signIn);
    SnackBarUtils.showCustomSnackBar(
      context,
      "Déconnexion réussie",
      SnackBarVariant.success,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LinkArrow(
      label: "Se déconnecter",
      onTap: _signOut,
      isRed: true,
    );
  }
}
