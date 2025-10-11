import 'dart:convert';

class CreatePunishmentResponse {
  final String? status;
  final String? message;
  final Punishment? data;

  CreatePunishmentResponse({this.status, this.message, this.data});

  factory CreatePunishmentResponse.fromJson(Map<String, dynamic> json) {
    return CreatePunishmentResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? Punishment.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  static CreatePunishmentResponse fromRawJson(String str) =>
      CreatePunishmentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class Punishment {
  final String? name;
  final String? description;
  final String? periodStartDate;
  final String? periodEndDate;
  final String? pointReduction;
  final int? missionId;
  final String? condition;
  final int? targetCount;
  final int? qtyCondition;
  final int? parentId;
  final int? childrenId;
  final String? status;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  Punishment({
    this.name,
    this.description,
    this.periodStartDate,
    this.periodEndDate,
    this.pointReduction,
    this.missionId,
    this.condition,
    this.targetCount,
    this.qtyCondition,
    this.parentId,
    this.childrenId,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Punishment.fromJson(Map<String, dynamic> json) => Punishment(
        name: json['name'] as String?,
        description: json['description'] as String?,
        periodStartDate: json['period_start_date'] as String?,
        periodEndDate: json['period_end_date'] as String?,
        pointReduction: json['point_reduction'] as String?,
        missionId: _parseIntOrNull(json['mission_id']),
        condition: json['condition'] as String?,
        targetCount: _parseIntOrNull(json['target_count']),
        qtyCondition: _parseIntOrNull(json['qty_condition']),
        parentId: _parseIntOrNull(json['parent_id']),
        childrenId: _parseIntOrNull(json['children_id']),
        status: json['status'] as String?,
        updatedAt: json['updated_at'] as String?,
        createdAt: json['created_at'] as String?,
        id: _parseIntOrNull(json['id']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'period_start_date': periodStartDate,
        'period_end_date': periodEndDate,
        'point_reduction': pointReduction,
        'mission_id': missionId,
        'condition': condition,
        'target_count': targetCount,
        'qty_condition': qtyCondition,
        'parent_id': parentId,
        'children_id': childrenId,
        'status': status,
        'updated_at': updatedAt,
        'created_at': createdAt,
        'id': id,
      };

  static int _parseInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static int? _parseIntOrNull(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
