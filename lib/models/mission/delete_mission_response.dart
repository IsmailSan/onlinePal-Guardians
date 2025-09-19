import 'dart:convert';

class DeleteMissionResponse {
  final String status;
  final String message;
  final Mission data;

  DeleteMissionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DeleteMissionResponse.fromMap(Map<String, dynamic> json) {
    return DeleteMissionResponse(
      status: json['status'],
      message: json['message'],
      data: Mission.fromMap(json['data']),
    );
  }

  factory DeleteMissionResponse.fromJson(String source) =>
      DeleteMissionResponse.fromMap(json.decode(source));

  Map<String, dynamic> toMap() => {
    'status': status,
    'message': message,
    'data': data.toMap(),
  };

  String toJson() => json.encode(toMap());
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
  final String appCategory;
  final String appName;
  final int missionSuggestionsId;
  final int parentId;
  final int childrenId;
  final String status;
  final String createdAt;
  final String updatedAt;

  Mission({
    required this.id,
    required this.name,
    required this.description,
    required this.periodeTime,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.condition,
    required this.appCategory,
    required this.appName,
    required this.missionSuggestionsId,
    required this.parentId,
    required this.childrenId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Mission.fromMap(Map<String, dynamic> json) => Mission(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    periodeTime: json['periode_time'],
    startDate: json['start_date'],
    endDate: json['end_date'],
    type: json['type'],
    condition: json['condition'],
    appCategory: json['app_category'],
    appName: json['app_name'],
    missionSuggestionsId: json['mission_suggestions_id'],
    parentId: json['parent_id'],
    childrenId: json['children_id'],
    status: json['status'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
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
}
