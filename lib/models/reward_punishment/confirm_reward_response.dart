import 'dart:convert';

class ConfirmRewardResponse {
  final String? status;
  final String? message;
  final DeleteReward? data;

  ConfirmRewardResponse({this.status, this.message, this.data});

  factory ConfirmRewardResponse.fromJson(Map<String, dynamic> json) {
    return ConfirmRewardResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? DeleteReward.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }

  static ConfirmRewardResponse fromRawJson(String str) =>
      ConfirmRewardResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class DeleteReward {
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

  DeleteReward({
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

  factory DeleteReward.fromJson(Map<String, dynamic> json) => DeleteReward(
        type: json['type'] as String?,
        pointsNeeded: json['points_needed'] as String?,
        periodStartDate: json['period_start_date'] as String?,
        periodEndDate: json['period_end_date'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        redemptionDateTime: json['redemption_date_time'] as String?,
        missionId: _parseIntOrNull(json['mission_id']),
        condition: json['condition'] as String?,
        targetCount: _parseInt(json['target_count']),
        qtyCondition: _parseInt(json['qty_condition']),
        parentId: _parseInt(json['parent_id']),
        childrenId: _parseInt(json['children_id']),
        approved: json['approved'] as bool?,
        requested: json['requested'] as bool? ?? false,
        status: json['status'] as String?,
        updatedAt: json['updated_at'] as String?,
        createdAt: json['created_at'] as String?,
        id: _parseInt(json['id']),
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
