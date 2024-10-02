import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/kermesse_details_response.dart';
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
}
