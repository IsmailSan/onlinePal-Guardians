class MarkAsReadNotifResponse {
  final String status;
  final String message;
  final MissionData? data;

  MarkAsReadNotifResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory MarkAsReadNotifResponse.fromJson(Map<String, dynamic> json) {
    return MarkAsReadNotifResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? MissionData.fromJson(json['data']) : null,
    );
  }
}

class MissionData {
  final List<Mission>? data;
  final int? nextCursor;

  MissionData({
    this.data,
    this.nextCursor,
  });

  factory MissionData.fromJson(Map<String, dynamic> json) {
    final list = json['data'] as List?;
    final missions = list != null
        ? list.map((e) => Mission.fromJson(e)).toList()
        : <Mission>[];

    return MissionData(
      data: missions,
      nextCursor: json['next_cursor'] as int?,
    );
  }
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

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      periodeTime: json['periode_time'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      type: json['type'] as String?,
      condition: json['condition'] as String?,
      appCategory: json['app_category'] as String?,
      appName: json['app_name'] as String?,
      missionSuggestionsId: json['mission_suggestions_id'] as int?,
      parentId: json['parent_id'] as int?,
      childrenId: json['children_id'] as int?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
