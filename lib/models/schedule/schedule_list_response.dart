class ScheduleListResponse {
  final String status;
  final String message;
  final ScheduleData? data;

  ScheduleListResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ScheduleListResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleListResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? ScheduleData.fromJson(json['data']) : null,
    );
  }
}

class ScheduleData {
  final List<Schedule>? data;

  ScheduleData({this.data});

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List?;
    List<Schedule>? schedules = list?.map((e) => Schedule.fromJson(e)).toList();
    return ScheduleData(data: schedules);
  }
}

class Schedule {
  final int? id;
  final String? date;
  final String? timeStart;
  final String? timeEnd;
  final int? scheduleItemId;
  final String? customName;
  final String? customCategory;
  final String? customIcon;
  final String? customColor;
  final String? notes;
  final int? createdById;
  final int? childrenId;
  final String? createdAt;
  final String? updatedAt;
  final dynamic scheduleItem;

  Schedule({
    this.id,
    this.date,
    this.timeStart,
    this.timeEnd,
    this.scheduleItemId,
    this.customName,
    this.customCategory,
    this.customIcon,
    this.customColor,
    this.notes,
    this.createdById,
    this.childrenId,
    this.createdAt,
    this.updatedAt,
    this.scheduleItem,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] as int?,
      date: json['date'] as String?,
      timeStart: json['time_start'] as String?,
      timeEnd: json['time_end'] as String?,
      scheduleItemId: json['schedule_item_id'] as int?,
      customName: json['custom_name'] as String?,
      customCategory: json['custom_category'] as String?,
      customIcon: json['custom_icon'] as String?,
      customColor: json['custom_color'] as String?,
      notes: json['notes'] as String?,
      createdById: json['created_by_id'] as int?,
      childrenId: json['children_id'] as int?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      scheduleItem: json['schedule_item'],
    );
  }
}
