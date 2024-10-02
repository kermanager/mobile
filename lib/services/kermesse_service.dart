import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/kermesse_create_request.dart';
import 'package:kermanager/data/kermesse_details_response.dart';
import 'package:kermanager/data/kermesse_edit_request.dart';
import 'package:kermanager/data/kermesse_list_response.dart';

class KermesseService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<KermesseListItem>>> list() {
    return _apiService.get<List<KermesseListItem>>(
      "kermesses",
      null,
      (data) {
        KermesseListResponse kermesseListResponse =
            KermesseListResponse.fromJson(data);
        return kermesseListResponse.kermesses;
      },
    );
  }

  Future<ApiResponse<KermesseDetailsResponse>> details({
    required int kermesseId,
  }) async {
    return _apiService.get<KermesseDetailsResponse>(
      "kermesses/$kermesseId",
      null,
      (data) {
        KermesseDetailsResponse kermesseDetailsResponse =
            KermesseDetailsResponse.fromJson(data);
        return kermesseDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required String name,
    required String description,
  }) async {
    KermesseCreateRequest body = KermesseCreateRequest(
      name: name,
      description: description,
    );

    return _apiService.post(
      "kermesses",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> edit({
    required int id,
    required String name,
    required String description,
  }) async {
    KermesseEditRequest body = KermesseEditRequest(
      name: name,
      description: description,
    );

    return _apiService.patch(
      "kermesses/$id",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> end({required int id}) async {
    return _apiService.patch(
      "kermesses/$id/end",
      "",
      (_) => null,
    );
  }
}
