import 'dart:convert';

class StandInviteRequest {
  final int standId;

  StandInviteRequest({
    required this.standId,
  });

  String toJson() {
    return json.encode({
      'stand_id': standId,
    });
  }
}
