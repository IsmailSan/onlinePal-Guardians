class ScheduleListResponse {
  final String status;
  final String message;
  final ScheduleData data;

  ScheduleListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ScheduleListResponse.fromJson(Map<String, dynamic> json) {
    return ScheduleListResponse(
      status: json['status'],
      message: json['message'],
      data: ScheduleData.fromJson(json['data']),
    );
  }
}

class ScheduleData {
  final List<Schedule> data;

  ScheduleData({required this.data});

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<Schedule> schedules = list.map((e) => Schedule.fromJson(e)).toList();
    return ScheduleData(data: schedules);
  }
}

class Schedule {
  final int id;
  final String date;
  final String timeStart;
  final String timeEnd;
  final int? scheduleItemId;
  final String customName;
  final String customCategory;
  final String customIcon;
  final String customColor;
  final String? notes;
  final int createdById;
  final int childrenId;
  final String createdAt;
  final String updatedAt;
  final dynamic scheduleItem;

  Schedule({
    required this.id,
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    this.scheduleItemId,
    required this.customName,
    required this.customCategory,
    required this.customIcon,
    required this.customColor,
    this.notes,
    required this.createdById,
    required this.childrenId,
    required this.createdAt,
    required this.updatedAt,
    this.scheduleItem,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      date: json['date'],
      timeStart: json['time_start'],
      timeEnd: json['time_end'],
      scheduleItemId: json['schedule_item_id'],
      customName: json['custom_name'],
      customCategory: json['custom_category'],
      customIcon: json['custom_icon'],
      customColor: json['custom_color'],
      notes: json['notes'],
      createdById: json['created_by_id'],
      childrenId: json['children_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      scheduleItem: json['schedule_item'],
    );
  }
}
