import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/interaction_list_response.dart';

class InteractionService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<InteractionListItem>>> list({int? kermesseId}) {
    return _apiService.get<List<InteractionListItem>>(
      "interactions",
      {
        'kermesse_id': kermesseId?.toString() ?? '',
      },
      (data) {
        InteractionListResponse interactionListResponse =
            InteractionListResponse.fromJson(data);
        return interactionListResponse.interactions;
      },
    );
  }
}
