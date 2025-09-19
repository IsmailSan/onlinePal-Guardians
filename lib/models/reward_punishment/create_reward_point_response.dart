import 'dart:convert';

class CreateRewardPointResponse {
  final String status;
  final String message;
  final RewardPoint data;

  CreateRewardPointResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateRewardPointResponse.fromJson(Map<String, dynamic> json) {
    return CreateRewardPointResponse(
      status: json['status'],
      message: json['message'],
      data: RewardPoint.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };

  static CreateRewardPointResponse fromRawJson(String str) =>
      CreateRewardPointResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class RewardPoint {
  final String type;
  final String pointsNeeded;
  final String periodStartDate;
  final String periodEndDate;
  final String name;
  final String? description;
  final String? redemptionDateTime;
  final int? missionId;
  final String? condition;
  final int targetCount;
  final int qtyCondition;
  final int parentId;
  final int childrenId;
  final bool? approved;
  final bool requested;
  final String status;
  final String updatedAt;
  final String createdAt;
  final int id;

  RewardPoint({
    required this.type,
    required this.pointsNeeded,
    required this.periodStartDate,
    required this.periodEndDate,
    required this.name,
    required this.description,
    required this.redemptionDateTime,
    required this.missionId,
    required this.condition,
    required this.targetCount,
    required this.qtyCondition,
    required this.parentId,
    required this.childrenId,
    required this.approved,
    required this.requested,
    required this.status,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory RewardPoint.fromJson(Map<String, dynamic> json) => RewardPoint(
    type: json['type'],
    pointsNeeded: json['points_needed'],
    periodStartDate: json['period_start_date'],
    periodEndDate: json['period_end_date'],
    name: json['name'],
    description: json['description'],
    redemptionDateTime: json['redemption_date_time'],
    missionId: json['mission_id'],
    condition: json['condition'],
    targetCount: _parseInt(json['target_count']),
    qtyCondition: _parseInt(json['qty_condition']),
    parentId: _parseInt(json['parent_id']),
    childrenId: _parseInt(json['children_id']),
    approved: json['approved'],
    requested: json['requested'] ?? false,
    status: json['status'],
    updatedAt: json['updated_at'],
    createdAt: json['created_at'],
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
}
