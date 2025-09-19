class MissionListResponse {
  final String status;
  final String message;
  final MissionData data;

  MissionListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MissionListResponse.fromJson(Map<String, dynamic> json) {
    return MissionListResponse(
      status: json['status'],
      message: json['message'],
      data: MissionData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data.toJson(),
      };
}

class MissionData {
  final List<Mission> data;
  final int? nextCursor;

  MissionData({
    required this.data,
    this.nextCursor,
  });

  factory MissionData.fromJson(Map<String, dynamic> json) {
    return MissionData(
      data: json['data'] != null
          ? List<Mission>.from(json['data'].map((x) => Mission.fromJson(x)))
          : <Mission>[], // fallback: kalau null, jadikan list kosong
      nextCursor: json['next_cursor'],
    );
  }

  Map<String, dynamic> toJson() => {
        'data': List<dynamic>.from(data.map((x) => x.toJson())),
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
