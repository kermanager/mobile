import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_list_response.dart';
import 'package:kermanager/router/parent/routes.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/widgets/screen_list.dart';

class ChildrenListScreen extends StatefulWidget {
  const ChildrenListScreen({
    super.key,
  });

  @override
  State<ChildrenListScreen> createState() => _ChildrenListScreenState();
}

class _ChildrenListScreenState extends State<ChildrenListScreen> {
  final Key _key = UniqueKey();

  final UserService _userService = UserService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response =
        await _userService.listChildren();
    if (response.error != null) {
      throw Exception(response.error);
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
            "Children List",
          ),
          Expanded(
            child: FutureBuilder<List<UserListItem>>(
              key: _key,
              future: _getAll(),
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
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      UserListItem item = snapshot.data![index];
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
                  );
                }
                return const Center(
                  child: Text('No users found'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
