import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_details_response.dart';
import 'package:kermanager/router/parent/routes.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/widgets/details_future_builder.dart';
import 'package:kermanager/widgets/screen.dart';
import 'package:kermanager/widgets/sign_out_button.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  const UserDetailsScreen({
    super.key,
    required this.userId,
  });

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final UserService _userService = UserService();

  Future<UserDetailsResponse> _get() async {
    ApiResponse<UserDetailsResponse> response = await _userService.details(
      userId: widget.userId,
    );
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      appBar: AppBar(
        title: const Text("Mon profil"),
      ),
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
                ElevatedButton(
                  onPressed: () {
                    context.push(
                      ParentRoutes.userEdit,
                    );
                  },
                  child: const Text("Update password"),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.push(
                      ParentRoutes.userCreditEdit,
                    );
                  },
                  child: const Text("Buy credit"),
                ),
                const SignOutButton(),
              ],
            );
          },
        ),
      ],
    );
  }
}
