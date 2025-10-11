import 'dart:convert';

class CreateRewardMissionResponse {
  final String? status;
  final String? message;
  final RewardMission? data;

  CreateRewardMissionResponse({this.status, this.message, this.data});

  factory CreateRewardMissionResponse.fromJson(Map<String, dynamic> json) {
    return CreateRewardMissionResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? RewardMission.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  static CreateRewardMissionResponse fromRawJson(String str) =>
      CreateRewardMissionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class RewardMission {
  final String? type;
  final String? pointsNeeded;
  final String? periodStartDate;
  final String? periodEndDate;
  final String? name;
  final String? description;
  final String? redemptionDateTime;
  final int? missionId;
  final String? condition;
  final int? targetCount;
  final int? qtyCondition;
  final int? parentId;
  final int? childrenId;
  final bool? approved;
  final bool? requested;
  final String? status;
  final String? updatedAt;
  final String? createdAt;
  final int? id;

  RewardMission({
    this.type,
    this.pointsNeeded,
    this.periodStartDate,
    this.periodEndDate,
    this.name,
    this.description,
    this.redemptionDateTime,
    this.missionId,
    this.condition,
    this.targetCount,
    this.qtyCondition,
    this.parentId,
    this.childrenId,
    this.approved,
    this.requested,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory RewardMission.fromJson(Map<String, dynamic> json) => RewardMission(
        type: json['type'] as String?,
        pointsNeeded: json['points_needed'] as String?,
        periodStartDate: json['period_start_date'] as String?,
        periodEndDate: json['period_end_date'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        redemptionDateTime: json['redemption_date_time'] as String?,
        missionId: _parseIntOrNull(json['mission_id']),
        condition: json['condition'] as String?,
        targetCount: _parseIntOrNull(json['target_count']),
        qtyCondition: _parseIntOrNull(json['qty_condition']),
        parentId: _parseIntOrNull(json['parent_id']),
        childrenId: _parseIntOrNull(json['children_id']),
        approved: json['approved'] as bool?,
        requested: json['requested'] as bool? ?? false,
        status: json['status'] as String?,
        updatedAt: json['updated_at'] as String?,
        createdAt: json['created_at'] as String?,
        id: _parseIntOrNull(json['id']),
      );

  Map<String, dynamic> toJson() => {
        'type': type,
        'points_needed': pointsNeeded,
        'period_start_date': periodStartDate,
        'period_end_date': periodEndDate,
        'name': name,
        'description': description,
        'redemption_date_time': redemptionDateTime,
        'mission_id': missionId,
        'condition': condition,
        'target_count': targetCount,
        'qty_condition': qtyCondition,
        'parent_id': parentId,
        'children_id': childrenId,
        'approved': approved,
        'requested': requested,
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
