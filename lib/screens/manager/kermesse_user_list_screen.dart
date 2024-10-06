import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_list_response.dart';
import 'package:kermanager/router/manager/routes.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/widgets/list_future_builder.dart';
import 'package:kermanager/widgets/screen_list.dart';

class KermesseUserListScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseUserListScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseUserListScreen> createState() => _KermesseUserListScreenState();
}

class _KermesseUserListScreenState extends State<KermesseUserListScreen> {
  final UserService _userService = UserService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response = await _userService.list(
      kermesseId: widget.kermesseId,
    );
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Kermesse User List",
          ),
          ElevatedButton(
            onPressed: () {
              context.push(
                ManagerRoutes.kermesseUserInvite,
                extra: {
                  'kermesseId': widget.kermesseId,
                },
              );
            },
            child: const Text('Invite'),
          ),
          Expanded(
            child: ListFutureBuilder<UserListItem>(
              future: _getAll,
              builder: (context, item) {
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.role),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
