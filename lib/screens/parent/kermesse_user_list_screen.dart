import 'package:flutter/material.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_list_response.dart';
import 'package:kermanager/services/user_service.dart';
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
  final Key _key = UniqueKey();

  final UserService _userService = UserService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response = await _userService.listChildren(
      kermesseId: widget.kermesseId,
    );
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
            "Kermesse User List",
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
