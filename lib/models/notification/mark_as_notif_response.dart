class MarkAsReadNotifResponse {
  final String status;
  final String message;
  final MissionData data;

  MarkAsReadNotifResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MarkAsReadNotifResponse.fromJson(Map<String, dynamic> json) {
    return MarkAsReadNotifResponse(
      status: json['status'],
      message: json['message'],
      data: MissionData.fromJson(json['data']),
    );
  }
}

class MissionData {
  final List<Mission> data;
  final int? nextCursor;

  MissionData({
    required this.data,
    this.nextCursor,
  });

  factory MissionData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Mission> missions = list.map((e) => Mission.fromJson(e)).toList();

    return MissionData(
      data: missions,
      nextCursor: json['next_cursor'] as int?,
    );
  }
}

class Mission {
  final int id;
  final String name;
  final String? description;
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
    this.description,
    required this.periodeTime,
    this.startDate,
    this.endDate,
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

  factory Mission.fromJson(Map<String, dynamic> json) {
    return Mission(
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
  }
}
