import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/stand_list_response.dart';

class StandService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<StandListItem>>> list({
    int? kermesseId,
    bool? isFree,
  }) {
    Map<String, String> params = {};
    if (kermesseId != null) {
      params['kermesse_id'] = kermesseId.toString();
    }
    if (isFree != null) {
      params['is_free'] = isFree.toString();
    }

    return _apiService.get<List<StandListItem>>(
      "stands",
      params,
      (data) {
        StandListResponse standListResponse = StandListResponse.fromJson(data);
        return standListResponse.stands;
      },
    );
  }
}
