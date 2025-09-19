import 'dart:convert';

class ConfirmPunishmentResponse {
  final String status;
  final String message;
  final Punishment data;

  ConfirmPunishmentResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ConfirmPunishmentResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmPunishmentResponse(
      status: json['status'],
      message: json['message'],
      data: Punishment.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };

  static ConfirmPunishmentResponse fromRawJson(String str) =>
      ConfirmPunishmentResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class Punishment {
  final String name;
  final String? description;
  final String periodStartDate;
  final String periodEndDate;
  final String? pointReduction; // ✅ bisa null
  final int missionId;
  final String condition;
  final int targetCount;
  final int qtyCondition;
  final int parentId;
  final int childrenId;
  final String status;
  final String updatedAt;
  final String createdAt;
  final int id;

  Punishment({
    required this.name,
    this.description, // ✅ nullable
    required this.periodStartDate,
    required this.periodEndDate,
    this.pointReduction, // ✅ nullable
    required this.missionId,
    required this.condition,
    required this.targetCount,
    required this.qtyCondition,
    required this.parentId,
    required this.childrenId,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Punishment.fromJson(Map<String, dynamic> json) => Punishment(
    name: json['name'],
    description: json['description'],
    periodStartDate: json['period_start_date'],
    periodEndDate: json['period_end_date'],
    pointReduction: json['point_reduction'], // ✅ accept null
    missionId: _parseInt(json['mission_id']),
    condition: json['condition'],
    targetCount: _parseInt(json['target_count']),
    qtyCondition: _parseInt(json['qty_condition']),
    parentId: _parseInt(json['parent_id']),
    childrenId: _parseInt(json['children_id']),
    status: json['status'],
    updatedAt: json['updated_at'],
    createdAt: json['created_at'],
    id: _parseInt(json['id']),
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
}
