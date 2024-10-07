import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_details_response.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/number_input.dart';
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
  final UserService _userService = UserService();

  final TextEditingController _amountController = TextEditingController();

  Future<UserDetailsResponse> _get() async {
    ApiResponse<UserDetailsResponse> response = await _userService.details(
      userId: widget.userId,
    );
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  Future<void> _send() async {
    ApiResponse<Null> response = await _userService.sendCredit(
      childId: widget.userId,
      amount: int.parse(_amountController.text),
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
          content: Text('Credit sent successfully'),
        ),
      );
    }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(data.id.toString()),
                Text(data.name),
                Text(data.email),
                Text(data.role),
                Text(data.credit.toString()),
                NumberInput(
                  hintText: "Amount",
                  controller: _amountController,
                ),
                ElevatedButton(
                  onPressed: _send,
                  child: const Text("Send credit"),
                ),
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
