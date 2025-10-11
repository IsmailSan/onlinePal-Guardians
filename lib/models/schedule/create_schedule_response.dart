import 'dart:convert';

class CreateScheduleResponse {
  final String status;
  final String message;
  final List<ScheduleItem>? data;

  CreateScheduleResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory CreateScheduleResponse.fromJson(Map<String, dynamic> json) {
    return CreateScheduleResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<ScheduleItem>.from(
              (json['data'] as List).map((x) => ScheduleItem.fromJson(x)),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((x) => x.toJson()).toList(),
      };

  static CreateScheduleResponse fromRawJson(String str) =>
      CreateScheduleResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class ScheduleItem {
  final String? date;
  final String? timeStart;
  final String? timeEnd;
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
    this.date,
    this.timeStart,
    this.timeEnd,
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
        date: json['date'] as String?,
        timeStart: json['time_start'] as String?,
        timeEnd: json['time_end'] as String?,
        scheduleItemId: json['schedule_item_id'] as int?,
        customName: json['custom_name'] as String?,
        customCategory: json['custom_category'] as String?,
        customIcon: json['custom_icon'] as String?,
        customColor: json['custom_color'] as String?,
        createdById: json['created_by_id'] as int?,
        childrenId: int.tryParse(json['children_id']?.toString() ?? ''),
        updatedAt: json['updated_at'] as String?,
        createdAt: json['created_at'] as String?,
        id: json['id'] as int?,
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
