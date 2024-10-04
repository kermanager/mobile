import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_list_response.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/widgets/child_select.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_input.dart';

class UserCreditSendScreen extends StatefulWidget {
  final int userId;

  const UserCreditSendScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserCreditSendScreen> createState() => _UserCreditSendScreenState();
}

class _UserCreditSendScreenState extends State<UserCreditSendScreen> {
  final TextEditingController _amountController = TextEditingController();

  final UserService _userService = UserService();

  int selectedChildId = 0;

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response =
        await _userService.listChildren();
    if (response.error != null) {
      throw Exception(response.error);
    }
    return response.data!;
  }

  Future<void> _submit() async {
    if (selectedChildId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a child'),
        ),
      );
      return;
    }
    ApiResponse<Null> response = await _userService.sendCredit(
      childId: selectedChildId,
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
          content: Text('Credit sent successfully'),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Send credit",
          ),
          ChildSelect(
            defaultValue: selectedChildId,
            onChange: (value) {
              setState(() {
                selectedChildId = value;
              });
            },
          ),
          TextInput(
            hintText: "Amount",
            controller: _amountController,
          ),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }
}
