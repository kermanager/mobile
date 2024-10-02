import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/tombola_create_request.dart';
import 'package:kermanager/data/tombola_list_response.dart';

class TombolaService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<TombolaListItem>>> list({int? kermesseId}) {
    return _apiService.get<List<TombolaListItem>>(
      "tombolas",
      {
        'kermesse_id': kermesseId?.toString() ?? '',
      },
      (data) {
        TombolaListResponse tombolaListResponse =
            TombolaListResponse.fromJson(data);
        return tombolaListResponse.tombolas;
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
}
