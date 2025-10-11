import 'dart:convert';

class UpdateRewardMissionResponse {
  final String? status;
  final String? message;
  final RewardMission? data;

  UpdateRewardMissionResponse({this.status, this.message, this.data});

  factory UpdateRewardMissionResponse.fromJson(Map<String, dynamic> json) =>
      UpdateRewardMissionResponse(
        status: json['status'] as String?,
        message: json['message'] as String?,
        data:
            json['data'] != null ? RewardMission.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  static UpdateRewardMissionResponse fromRawJson(String str) =>
      UpdateRewardMissionResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class RewardMission {
  final int? id;
  final String? type;
  final String? periodStartDate;
  final String? periodEndDate;
  final String? name;
  final String? description;
  final int? parentId;
  final int? childrenId;
  final int? requested; // ubah ke int?
  final String? redemptionDateTime;
  final int? approved; // ubah ke int?
  final int? pointsNeeded; // ubah ke int?
  final int? missionId;
  final String? condition;
  final int? qtyCondition;
  final int? targetCount;
  final int? pointAddition; // tambahkan
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  RewardMission({
    this.id,
    this.type,
    this.periodStartDate,
    this.periodEndDate,
    this.name,
    this.description,
    this.parentId,
    this.childrenId,
    this.requested,
    this.redemptionDateTime,
    this.approved,
    this.pointsNeeded,
    this.missionId,
    this.condition,
    this.qtyCondition,
    this.targetCount,
    this.pointAddition,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory RewardMission.fromJson(Map<String, dynamic> json) => RewardMission(
        id: _parseIntOrNull(json['id']),
        type: json['type'] as String?,
        periodStartDate: json['period_start_date'] as String?,
        periodEndDate: json['period_end_date'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        parentId: _parseIntOrNull(json['parent_id']),
        childrenId: _parseIntOrNull(json['children_id']),
        requested: _parseIntOrNull(json['requested']),
        redemptionDateTime: json['redemption_date_time'] as String?,
        approved: _parseIntOrNull(json['approved']),
        pointsNeeded: _parseIntOrNull(json['points_needed']),
        missionId: _parseIntOrNull(json['mission_id']),
        condition: json['condition'] as String?,
        qtyCondition: _parseIntOrNull(json['qty_condition']),
        targetCount: _parseIntOrNull(json['target_count']),
        pointAddition: _parseIntOrNull(json['point_addition']),
        status: json['status'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
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
        'requested': requested,
        'redemption_date_time': redemptionDateTime,
        'approved': approved,
        'points_needed': pointsNeeded,
        'mission_id': missionId,
        'condition': condition,
        'qty_condition': qtyCondition,
        'target_count': targetCount,
        'point_addition': pointAddition,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  static int? _parseIntOrNull(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is String) return int.tryParse(value);
    return null;
  }
}
