import 'dart:convert';

import 'package:intl/intl.dart';

class InteractionUser {
  final int id;
  final String name;
  final String email;
  final String role;

  InteractionUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });

  factory InteractionUser.fromMap(Map<String, dynamic> json) {
    return InteractionUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'],
    );
  }

  factory InteractionUser.fromJson(String source) {
    return InteractionUser.fromMap(json.decode(source));
  }
}

class InteractionStand {
  final int id;
  final String name;
  final String description;
  final String type;
  final int price;

  InteractionStand({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.price,
  });

  factory InteractionStand.fromMap(Map<String, dynamic> json) {
    return InteractionStand(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: json['type'],
      price: json['price'],
    );
  }

  factory InteractionStand.fromJson(String source) {
    return InteractionStand.fromMap(json.decode(source));
  }
}

class InteractionListItem {
  final int id;
  final String type;
  final String status;
  final int credit;
  final int point;
  final DateTime createdAt;
  final InteractionUser user;
  final InteractionStand stand;

  InteractionListItem({
    required this.id,
    required this.type,
    required this.status,
    required this.credit,
    required this.point,
    required this.createdAt,
    required this.user,
    required this.stand,
  });

  factory InteractionListItem.fromMap(Map<String, dynamic> json) {
    return InteractionListItem(
      id: json['id'],
      type: json['type'],
      status: json['status'],
      credit: json['credit'],
      point: json['point'],
      createdAt: DateTime.parse(json['created_at']),
      user: InteractionUser.fromMap(json['user']),
      stand: InteractionStand.fromMap(json['stand']),
    );
  }

  factory InteractionListItem.fromJson(String source) {
    return InteractionListItem.fromMap(json.decode(source));
  }

  get formattedCreatedAt => DateFormat("MMM d, y 'à' HH:mm").format(createdAt);
}

class InteractionListResponse {
  final List<InteractionListItem> interactions;

  InteractionListResponse({
    required this.interactions,
  });

  factory InteractionListResponse.fromList(List<dynamic> list) {
    return InteractionListResponse(
      interactions:
          list.map((item) => InteractionListItem.fromMap(item)).toList(),
    );
  }

  factory InteractionListResponse.fromJson(String source) {
    return InteractionListResponse.fromList(json.decode(source));
  }
}
