import 'dart:convert';

class CreateNewMissionResponse {
  final String status;
  final String message;
  final Mission data;

  CreateNewMissionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateNewMissionResponse.fromJson(Map<String, dynamic> json) {
    return CreateNewMissionResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: Mission.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data.toJson(),
      };

  static CreateNewMissionResponse fromRawJson(String str) =>
      CreateNewMissionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class Mission {
  final int id;
  final String name;
  final String description;
  final String periodeTime;
  final String? startDate;
  final String? endDate;
  final String type;
  final String condition;
  final int parentId;
  final int childrenId;
  final String status;
  final String createdAt;
  final String updatedAt;

  // opsional (karena backend tidak selalu kirim)
  final String? appCategory;
  final String? appName;
  final int? missionSuggestionsId;
  final int? categoryAppsId;
  final int? appsId;

  Mission({
    required this.id,
    required this.name,
    required this.description,
    required this.periodeTime,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.condition,
    required this.parentId,
    required this.childrenId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.appCategory,
    this.appName,
    this.missionSuggestionsId,
    this.categoryAppsId,
    this.appsId,
  });

  factory Mission.fromJson(Map<String, dynamic> json) => Mission(
        id: _parseInt(json['id']),
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        periodeTime: json['periode_time'] ?? '',
        startDate: json['start_date'],
        endDate: json['end_date'],
        type: json['type'] ?? '',
        condition: json['condition'] ?? '',
        parentId: _parseInt(json['parent_id']),
        childrenId: _parseInt(json['children_id']),
        status: json['status'] ?? '',
        createdAt: json['created_at'] ?? '',
        updatedAt: json['updated_at'] ?? '',

        // opsional
        appCategory: json['app_category'],
        appName: json['app_name'],
        missionSuggestionsId: _parseInt(json['mission_suggestions_id']),
        categoryAppsId: _parseInt(json['category_apps_id']),
        appsId: _parseInt(json['apps_id']),
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
        'parent_id': parentId,
        'children_id': childrenId,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,

        // opsional
        'app_category': appCategory,
        'app_name': appName,
        'mission_suggestions_id': missionSuggestionsId,
        'category_apps_id': categoryAppsId,
        'apps_id': appsId,
      };

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
