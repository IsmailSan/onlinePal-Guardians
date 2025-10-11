import 'dart:convert';

class DeleteMissionResponse {
  final String? status;
  final String? message;
  final Mission? data;

  DeleteMissionResponse({
    this.status,
    this.message,
    this.data,
  });

  factory DeleteMissionResponse.fromMap(Map<String, dynamic> json) {
    return DeleteMissionResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null ? Mission.fromMap(json['data']) : null,
    );
  }

  factory DeleteMissionResponse.fromJson(String source) =>
      DeleteMissionResponse.fromMap(json.decode(source));

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data?.toMap(),
      };

  String toJson() => json.encode(toMap());
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

  factory Mission.fromMap(Map<String, dynamic> json) => Mission(
        id: _parseInt(json['id']),
        name: json['name'] as String?,
        description: json['description'] as String?,
        periodeTime: json['periode_time'] as String?,
        startDate: json['start_date'] as String?,
        endDate: json['end_date'] as String?,
        type: json['type'] as String?,
        condition: json['condition'] as String?,
        appCategory: json['app_category'] as String?,
        appName: json['app_name'] as String?,
        missionSuggestionsId: _parseInt(json['mission_suggestions_id']),
        parentId: _parseInt(json['parent_id']),
        childrenId: _parseInt(json['children_id']),
        status: json['status'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  Map<String, dynamic> toMap() => {
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
