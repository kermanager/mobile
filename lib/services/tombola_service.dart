import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
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
}
