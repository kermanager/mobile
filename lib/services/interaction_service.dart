import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/interaction_create_request.dart';
import 'package:kermanager/data/interaction_details_response.dart';
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

  Future<ApiResponse<InteractionDetailsResponse>> details({
    required int interactionId,
  }) async {
    return _apiService.get<InteractionDetailsResponse>(
      "interactions/$interactionId",
      null,
      (data) {
        InteractionDetailsResponse interactionDetailsResponse =
            InteractionDetailsResponse.fromJson(data);
        return interactionDetailsResponse;
      },
    );
  }

  Future<ApiResponse<Null>> create({
    required int kermesseId,
    required int standId,
    required int quantity,
  }) async {
    InteractionCreateRequest body = InteractionCreateRequest(
      kermesseId: kermesseId,
      standId: standId,
      quantity: quantity,
    );

    return _apiService.post(
      "interactions",
      body.toJson(),
      (_) => null,
    );
  }
}
