import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_list_response.dart';
import 'package:kermanager/router/parent/routes.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/widgets/list_future_builder.dart';
import 'package:kermanager/widgets/screen_list.dart';

class ChildrenListScreen extends StatefulWidget {
  const ChildrenListScreen({
    super.key,
  });

  @override
  State<ChildrenListScreen> createState() => _ChildrenListScreenState();
}

class _ChildrenListScreenState extends State<ChildrenListScreen> {
  final UserService _userService = UserService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response =
        await _userService.listChildren();
    if (response.error != null) {
      throw Exception(response.errorMessage);
    }
    return response.data!;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      children: [
        const Text(
          "Children List",
        ),
        ElevatedButton(
          onPressed: () {
            context.push(
              ParentRoutes.childrenInvite,
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
                onTap: () {
                  context.push(
                    ParentRoutes.childrenDetails,
                    extra: {
                      "userId": item.id,
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
