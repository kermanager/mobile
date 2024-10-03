import 'package:kermanager/api/api_response.dart';
import 'package:kermanager/api/api_service.dart';
import 'package:kermanager/data/ticket_details_response.dart';
import 'package:kermanager/data/ticket_list_response.dart';

class TicketService {
  final ApiService _apiService = ApiService();

  Future<ApiResponse<List<TicketListItem>>> list() {
    return _apiService.get<List<TicketListItem>>(
      "tickets",
      null,
      (data) {
        TicketListResponse ticketListResponse =
            TicketListResponse.fromJson(data);
        return ticketListResponse.tickets;
      },
    );
  }

  Future<ApiResponse<TicketDetailsResponse>> details({
    required int ticketId,
  }) async {
    return _apiService.get<TicketDetailsResponse>(
      "tickets/$ticketId",
      null,
      (data) {
        TicketDetailsResponse ticketDetailsResponse =
            TicketDetailsResponse.fromJson(data);
        return ticketDetailsResponse;
      },
    );
  }
}
