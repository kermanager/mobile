import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/user_details_response.dart';
import 'package:kermanager/data/user_edit_request.dart';
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

  Future<ApiResponse<UserDetailsResponse>> details({
    required int userId,
  }) async {
    return _apiService.get<UserDetailsResponse>(
      "users/$userId",
      null,
      (data) {
        UserDetailsResponse userDetailsResponse =
            UserDetailsResponse.fromJson(data);
        return userDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> edit({
    required int userId,
    required String password,
    required String newPassword,
  }) async {
    UserEditRequest body = UserEditRequest(
      password: password,
      newPassword: newPassword,
    );

    return _apiService.patch(
      "users/$userId",
      body.toJson(),
      (_) => null,
    );
  }
}
