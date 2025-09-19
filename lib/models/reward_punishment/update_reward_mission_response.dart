import 'dart:convert';

class UpdateRewardMissionResponse {
  final String status;
  final String message;
  final RewardMission data;

  UpdateRewardMissionResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateRewardMissionResponse.fromJson(Map<String, dynamic> json) =>
      UpdateRewardMissionResponse(
        status: json['status'],
        message: json['message'],
        data: RewardMission.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };

  static UpdateRewardMissionResponse fromRawJson(String str) =>
      UpdateRewardMissionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class RewardMission {
  final int id;
  final String type;
  final String periodStartDate;
  final String periodEndDate;
  final String name;
  final String? description;
  final int parentId;
  final int childrenId;
  final bool requested;
  final String? redemptionDateTime;
  final bool? approved;
  final String? pointsNeeded;
  final int? missionId;
  final String? condition;
  final int qtyCondition;
  final int targetCount;
  final String status;
  final String createdAt;
  final String updatedAt;

  RewardMission({
    required this.id,
    required this.type,
    required this.periodStartDate,
    required this.periodEndDate,
    required this.name,
    required this.description,
    required this.parentId,
    required this.childrenId,
    required this.requested,
    required this.redemptionDateTime,
    required this.approved,
    required this.pointsNeeded,
    required this.missionId,
    required this.condition,
    required this.qtyCondition,
    required this.targetCount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RewardMission.fromJson(Map<String, dynamic> json) => RewardMission(
    id: _parseInt(json['id']),
    type: json['type'],
    periodStartDate: json['period_start_date'],
    periodEndDate: json['period_end_date'],
    name: json['name'],
    description: json['description'],
    parentId: _parseInt(json['parent_id']),
    childrenId: _parseInt(json['children_id']),
    requested: json['requested'] == 1,
    redemptionDateTime: json['redemption_date_time'],
    approved: json['approved'],
    pointsNeeded: json['points_needed'],
    missionId: _parseIntOrNull(json['mission_id']),
    condition: json['condition'],
    qtyCondition: _parseInt(json['qty_condition']),
    targetCount: _parseInt(json['target_count']),
    status: json['status'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'period_start_date': periodStartDate,
    'period_end_date': periodEndDate,
    'name': name,
    'description': description,
    'parent_id': parentId,
    'children_id': childrenId,
    'requested': requested ? 1 : 0,
    'redemption_date_time': redemptionDateTime,
    'approved': approved,
    'points_needed': pointsNeeded,
    'mission_id': missionId,
    'condition': condition,
    'qty_condition': qtyCondition,
    'target_count': targetCount,
    'status': status,
    'created_at': createdAt,
    'updated_at': updatedAt,
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
