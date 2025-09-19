class SuggestedSchedulesResponse {
  final String status;
  final String message;
  final SuggestedScheduleData data;

  SuggestedSchedulesResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory SuggestedSchedulesResponse.fromJson(Map<String, dynamic> json) {
    return SuggestedSchedulesResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: SuggestedScheduleData.fromJson(json['data']),
    );
  }
}

class SuggestedScheduleData {
  final List<SuggestedSchedule> data;
  final int? nextCursor;

  SuggestedScheduleData({
    required this.data,
    this.nextCursor,
  });

  factory SuggestedScheduleData.fromJson(Map<String, dynamic> json) {
    return SuggestedScheduleData(
      data: (json['data'] as List<dynamic>)
          .map((item) => SuggestedSchedule.fromJson(item))
          .toList(),
      nextCursor: json['next_cursor'] is int ? json['next_cursor'] : null,
    );
  }
}

class SuggestedSchedule {
  final int? id;
  final String? name;
  final String? category;
  final String? icon;
  final String? color;
  final String? createdAt;
  final String? updatedAt;

  SuggestedSchedule({
    this.id,
    this.name,
    this.category,
    this.icon,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  factory SuggestedSchedule.fromJson(Map<String, dynamic> json) {
    return SuggestedSchedule(
      id: json['id'] as int?,
      name: json['name'] as String?,
      category: json['category'] as String?,
      icon: json['icon'] as String?,
      color: json['color'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
