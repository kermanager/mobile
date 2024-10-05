import 'dart:convert';

class KermesseDetailsResponse {
  final int id;
  final int userId;
  final String name;
  final String description;
  final String status;
  final int standCount;
  final int tombolaCount;
  final int userCount;
  final int interactionCount;
  final int interactionIncome;
  final int tombolaIncome;
  final int points;

  KermesseDetailsResponse({
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.status,
    required this.standCount,
    required this.tombolaCount,
    required this.userCount,
    required this.interactionCount,
    required this.interactionIncome,
    required this.tombolaIncome,
    required this.points,
  });

  factory KermesseDetailsResponse.fromMap(Map<String, dynamic> json) {
    return KermesseDetailsResponse(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      description: json['description'],
      status: json['status'],
      standCount: json['stand_count'],
      tombolaCount: json['tombola_count'],
      userCount: json['user_count'],
      interactionCount: json['interaction_count'],
      interactionIncome: json['interaction_income'],
      tombolaIncome: json['tombola_income'],
      points: json['points'],
    );
  }

  factory KermesseDetailsResponse.fromJson(String source) {
    return KermesseDetailsResponse.fromMap(json.decode(source));
  }
}
