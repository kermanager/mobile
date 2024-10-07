import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/theme/theme_size.dart';
import 'package:kermanager/widgets/button.dart';
import 'package:kermanager/widgets/form_column.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_form_input.dart';

class ChildrenInviteScreen extends StatefulWidget {
  const ChildrenInviteScreen({super.key});

  @override
  State<ChildrenInviteScreen> createState() => _ChildrenInviteScreenState();
}

class _ChildrenInviteScreenState extends State<ChildrenInviteScreen> {
  final _formKey = GlobalKey<FormState>();

  final UserService _userService = UserService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      ApiResponse<Null> response = await _userService.invite(
        name: _nameController.text,
        email: _emailController.text,
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
            content: Text('User invited successfully'),
          ),
        );
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text("Inviter un enfant"),
      ),
      children: [
        FormColumn(
          formKey: _formKey,
          children: [
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
            Button(
              label: "Inviter",
              onTap: _submit,
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
    super.dispose();
  }
}
