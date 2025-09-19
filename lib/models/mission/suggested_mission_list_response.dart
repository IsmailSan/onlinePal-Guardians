class SuggestedMissionListResponse {
  final String status;
  final String message;
  final SuggestedMissionListData data;

  SuggestedMissionListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SuggestedMissionListResponse.fromJson(Map<String, dynamic> json) {
    return SuggestedMissionListResponse(
      status: json['status'],
      message: json['message'],
      data: SuggestedMissionListData.fromJson(json['data']),
    );
  }
}

class SuggestedMissionListData {
  final List<SuggestedMission> data;
  final int? nextCursor;

  SuggestedMissionListData({
    required this.data,
    required this.nextCursor,
  });

  factory SuggestedMissionListData.fromJson(Map<String, dynamic> json) {
    return SuggestedMissionListData(
      data: List<SuggestedMission>.from(
          json['data'].map((x) => SuggestedMission.fromJson(x))),
      nextCursor: json['next_cursor'] is int ? json['next_cursor'] : null,
    );
  }
}

class SuggestedMission {
  final int? id;
  final String? name;
  final String? description;
  final String? periodeTime;
  final String? startDate;
  final String? endDate;
  final String? type;
  final String? condition;
  final String? specificTimeOfDay;
  final String? appCategory;
  final String? appName;
  final String? createdAt;
  final String? updatedAt;

  SuggestedMission({
    this.id,
    this.name,
    this.description,
    this.periodeTime,
    this.startDate,
    this.endDate,
    this.type,
    this.condition,
    this.specificTimeOfDay,
    this.appCategory,
    this.appName,
    this.createdAt,
    this.updatedAt,
  });

  factory SuggestedMission.fromJson(Map<String, dynamic> json) {
    return SuggestedMission(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      periodeTime: json['periode_time'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      type: json['type'],
      condition: json['condition'],
      specificTimeOfDay: json['specific_time_of_day'],
      appCategory: json['app_category'],
      appName: json['app_name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
