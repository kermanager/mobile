import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/data/user_list_response.dart';
import 'package:kermanager/services/kermesse_service.dart';
import 'package:kermanager/services/user_service.dart';
import 'package:kermanager/widgets/list_future_builder.dart';
import 'package:kermanager/widgets/screen_list.dart';

class KermesseUserInviteScreen extends StatefulWidget {
  final int kermesseId;

  const KermesseUserInviteScreen({
    super.key,
    required this.kermesseId,
  });

  @override
  State<KermesseUserInviteScreen> createState() =>
      _KermesseUserInviteScreenState();
}

class _KermesseUserInviteScreenState extends State<KermesseUserInviteScreen> {
  final UserService _userService = UserService();
  final KermesseService _kermesseService = KermesseService();

  Future<List<UserListItem>> _getAll() async {
    ApiResponse<List<UserListItem>> response =
        await _userService.listInviteKermesse(kermesseId: widget.kermesseId);
    if (response.error != null) {
      throw Exception(response.error!);
    }
    return response.data!;
  }

  Future<void> _invite(int userId) async {
    ApiResponse<Null> response = await _kermesseService.inviteUser(
      kermesseId: widget.kermesseId,
      userId: userId,
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
          content: Text('User invited successfully'),
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenList(
      appBar: AppBar(
        title: const Text("Inviter un enfant"),
      ),
      children: [
        Expanded(
          child: ListFutureBuilder<UserListItem>(
            future: _getAll,
            builder: (context, item) {
              return ListTile(
                title: Text(item.name),
                subtitle: Text(item.email),
                leading: ElevatedButton(
                  onPressed: () async {
                    await _invite(item.id);
                  },
                  child: const Text('Invite'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
