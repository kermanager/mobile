import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/tombola_create_request.dart';
import 'package:kermanager/data/tombola_details_response.dart';
import 'package:kermanager/data/tombola_edit_request.dart';
import 'package:kermanager/data/tombola_list_response.dart';

class TombolaService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<TombolaListItem>>> list({int? kermesseId}) {
    Map<String, String> params = {};
    if (kermesseId != null) {
      params['kermesse_id'] = kermesseId.toString();
    }

    return _apiService.get<List<TombolaListItem>>(
      "tombolas",
      params,
      (data) {
        TombolaListResponse tombolaListResponse =
            TombolaListResponse.fromJson(data);
        return tombolaListResponse.tombolas;
      },
    );
  }

  Future<ApiResponse<TombolaDetailsResponse>> details({
    required int tombolaId,
  }) async {
    return _apiService.get<TombolaDetailsResponse>(
      "tombolas/$tombolaId",
      null,
      (data) {
        TombolaDetailsResponse tombolaDetailsResponse =
            TombolaDetailsResponse.fromJson(data);
        return tombolaDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required int kermesseId,
    required String name,
    required int price,
    required String gift,
  }) async {
    TombolaCreateRequest body = TombolaCreateRequest(
      kermesseId: kermesseId,
      name: name,
      price: price,
      gift: gift,
    );

    return _apiService.post(
      "tombolas",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> edit({
    required int id,
    required String name,
    required int price,
    required String gift,
  }) async {
    TombolaEditRequest body = TombolaEditRequest(
      name: name,
      price: price,
      gift: gift,
    );

    return _apiService.patch(
      "tombolas/$id",
      body.toJson(),
      (_) => null,
    );
  }

  Future<ApiResponse<Null>> end({required int tombolaId}) async {
    return _apiService.patch(
      "tombolas/$tombolaId/end",
      "",
      (_) => null,
    );
  }
}
