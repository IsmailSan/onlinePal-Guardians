import 'dart:convert';

class UpdateScheduleResponse {
  final String status;
  final String message;
  final ScheduleData? data;

  UpdateScheduleResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory UpdateScheduleResponse.fromJson(Map<String, dynamic> json) {
    return UpdateScheduleResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: json['data'] != null ? ScheduleData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  static UpdateScheduleResponse fromRawJson(String str) =>
      UpdateScheduleResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class ScheduleData {
  final List<ScheduleItem>? data;

  ScheduleData({this.data});

  factory ScheduleData.fromJson(Map<String, dynamic> json) {
    return ScheduleData(
      data: json['data'] != null
          ? List<ScheduleItem>.from(
              (json['data'] as List).map((x) => ScheduleItem.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'data': data?.map((x) => x.toJson()).toList(),
      };
}

class ScheduleItem {
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

  ScheduleItem({
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

  factory ScheduleItem.fromJson(Map<String, dynamic> json) => ScheduleItem(
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'time_start': timeStart,
        'time_end': timeEnd,
        'schedule_item_id': scheduleItemId,
        'custom_name': customName,
        'custom_category': customCategory,
        'custom_icon': customIcon,
        'custom_color': customColor,
        'notes': notes,
        'created_by_id': createdById,
        'children_id': childrenId,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'schedule_item': scheduleItem,
      };
}
