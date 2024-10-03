import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/user_list_response.dart';

class UserService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<UserListItem>>> list({int? kermesseId}) {
    return _apiService.get<List<UserListItem>>(
      "users",
      {
        'kermesse_id': kermesseId?.toString() ?? '',
      },
      (data) {
        UserListResponse userListResponse = UserListResponse.fromJson(data);
        return userListResponse.users;
      },
    );
  }

  Future<ApiResponse<List<UserListItem>>> listInviteKermesse({
    required int kermesseId,
  }) {
    return _apiService.get<List<UserListItem>>(
      "kermesses/$kermesseId/users",
      null,
      (data) {
        UserListResponse userListResponse = UserListResponse.fromJson(data);
        return userListResponse.users;
      },
    );
  }
}
