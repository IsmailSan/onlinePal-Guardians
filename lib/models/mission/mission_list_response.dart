class MissionListResponse {
  final String status;
  final String message;
  final MissionData? data;

  MissionListResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory MissionListResponse.fromJson(Map<String, dynamic> json) {
    return MissionListResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? MissionData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };
}

class MissionData {
  final List<Mission>? data;
  final int? nextCursor;

  MissionData({
    this.data,
    this.nextCursor,
  });

  factory MissionData.fromJson(Map<String, dynamic> json) {
    return MissionData(
      data: json['data'] != null
          ? List<Mission>.from(
              (json['data'] as List).map((x) => Mission.fromJson(x)),
            )
          : null,
      nextCursor: _parseInt(json['next_cursor']),
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((x) => x.toJson()).toList(),
        'next_cursor': nextCursor,
      };
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
}

/// Helper supaya parsing int aman
int? _parseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is String) return int.tryParse(value);
  return null;
}
