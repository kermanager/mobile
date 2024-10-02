import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/stand_list_response.dart';

class StandService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<StandListItem>>> list({int? kermesseId}) {
    return _apiService.get<List<StandListItem>>(
      "stands",
      {
        'kermesse_id': kermesseId?.toString() ?? '',
      },
      (data) {
        StandListResponse standListResponse = StandListResponse.fromJson(data);
        return standListResponse.stands;
      },
    );
  }
}
