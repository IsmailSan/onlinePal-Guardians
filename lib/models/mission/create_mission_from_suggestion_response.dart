import 'dart:convert';

class CreateMissionFromSuggestionResponse {
  final String status;
  final String message;
  final Mission? data;

  CreateMissionFromSuggestionResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory CreateMissionFromSuggestionResponse.fromJson(
      Map<String, dynamic> json) {
    return CreateMissionFromSuggestionResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? Mission.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  static CreateMissionFromSuggestionResponse fromRawJson(String str) =>
      CreateMissionFromSuggestionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class Mission {
  final int? id;
  final String? name;
  final String? description;
  final String? periodeTime;
  final String? startDate;
  final String? endDate;
  final String? type;
  final String? condition;
  final String? appCategory;
  final String? appName;
  final int? missionSuggestionsId;
  final int? parentId;
  final int? childrenId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Mission({
    this.id,
    this.name,
    this.description,
    this.periodeTime,
    this.startDate,
    this.endDate,
    this.type,
    this.condition,
    this.appCategory,
    this.appName,
    this.missionSuggestionsId,
    this.parentId,
    this.childrenId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Mission.fromJson(Map<String, dynamic> json) => Mission(
        id: _parseInt(json['id']),
        name: json['name'],
        description: json['description'],
        periodeTime: json['periode_time'],
        startDate: json['start_date'],
        endDate: json['end_date'],
        type: json['type'],
        condition: json['condition'],
        appCategory: json['app_category'],
        appName: json['app_name'],
        missionSuggestionsId: _parseInt(json['mission_suggestions_id']),
        parentId: _parseInt(json['parent_id']),
        childrenId: _parseInt(json['children_id']),
        status: json['status'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'periode_time': periodeTime,
        'start_date': startDate,
        'end_date': endDate,
        'type': type,
        'condition': condition,
        'app_category': appCategory,
        'app_name': appName,
        'mission_suggestions_id': missionSuggestionsId,
        'parent_id': parentId,
        'children_id': childrenId,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
