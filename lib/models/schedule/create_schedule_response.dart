import 'dart:convert';

class CreateScheduleResponse {
  final String status;
  final String message;
  final List<ScheduleItem> data;

  CreateScheduleResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateScheduleResponse.fromJson(Map<String, dynamic> json) {
    return CreateScheduleResponse(
      status: json['status'],
      message: json['message'],
      data: List<ScheduleItem>.from(
        json['data'].map((x) => ScheduleItem.fromJson(x)),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
  };

  static CreateScheduleResponse fromRawJson(String str) =>
      CreateScheduleResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class ScheduleItem {
  final String date;
  final String timeStart;
  final String timeEnd;
  final int? scheduleItemId;
  final String? customName;
  final String? customCategory;
  final String? customIcon;
  final String? customColor;
  final int? createdById;
  final int? childrenId;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  ScheduleItem({
    required this.date,
    required this.timeStart,
    required this.timeEnd,
    this.scheduleItemId,
    this.customName,
    this.customCategory,
    this.customIcon,
    this.customColor,
    this.createdById,
    this.childrenId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory ScheduleItem.fromJson(Map<String, dynamic> json) => ScheduleItem(
    date: json['date'] ?? '',
    timeStart: json['time_start'] ?? '',
    timeEnd: json['time_end'] ?? '',
    scheduleItemId: json['schedule_item_id'],
    customName: json['custom_name'],
    customCategory: json['custom_category'],
    customIcon: json['custom_icon'],
    customColor: json['custom_color'],
    createdById: json['created_by_id'],
    childrenId: int.tryParse(json['children_id']?.toString() ?? '') ?? null,
    updatedAt: json['updated_at'],
    createdAt: json['created_at'],
    id: json['id'],
  );

  Map<String, dynamic> toJson() => {
    'date': date,
    'time_start': timeStart,
    'time_end': timeEnd,
    'schedule_item_id': scheduleItemId,
    'custom_name': customName,
    'custom_category': customCategory,
    'custom_icon': customIcon,
    'custom_color': customColor,
    'created_by_id': createdById,
    'children_id': childrenId,
    'updated_at': updatedAt,
    'created_at': createdAt,
    'id': id,
  };
}

