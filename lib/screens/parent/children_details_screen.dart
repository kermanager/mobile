import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_details_response.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/text_input.dart';

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
  final Key _key = UniqueKey();
  final TextEditingController _amountController = TextEditingController();

  final UserService _userService = UserService();

  Future<UserDetailsResponse> _get() async {
    ApiResponse<UserDetailsResponse> response = await _userService.details(
      userId: widget.userId,
    );
    if (response.error != null) {
      throw Exception(response.error);
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
          content: Text(response.error!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Credit sent successfully'),
        ),
      );
      _refresh();
    }
  }

  void _refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Children Details",
          ),
          FutureBuilder<UserDetailsResponse>(
            key: _key,
            future: _get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    snapshot.error.toString(),
                  ),
                );
              }
              if (snapshot.hasData) {
                UserDetailsResponse data = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(data.id.toString()),
                    Text(data.name),
                    Text(data.email),
                    Text(data.role),
                    Text(data.credit.toString()),
                    TextInput(
                      hintText: "Amount",
                      controller: _amountController,
                    ),
                    ElevatedButton(
                      onPressed: _send,
                      child: const Text("Send credit"),
                    ),
                  ],
                );
              }
              return const Center(
                child: Text('Something went wrong'),
              );
            },
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
