import 'dart:convert';

class ActiveRewardListResponse {
  final String? status;
  final String? message;
  final RewardListData? data;

  ActiveRewardListResponse({this.status, this.message, this.data});

  factory ActiveRewardListResponse.fromJson(Map<String, dynamic> json) {
    return ActiveRewardListResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? RewardListData.fromJson(json['data'] as Map<String, dynamic>)
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

  static ActiveRewardListResponse fromRawJson(String str) =>
      ActiveRewardListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class RewardListData {
  final List<RewardItem>? data;
  final int? nextCursor;

  RewardListData({this.data, this.nextCursor});

  factory RewardListData.fromJson(Map<String, dynamic> json) {
    return RewardListData(
      data: json['data'] != null
          ? List<RewardItem>.from(
              (json['data'] as List).map((x) => RewardItem.fromJson(x)))
          : [],
      nextCursor: json['next_cursor'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((x) => x.toJson()).toList(),
      'next_cursor': nextCursor,
    };
  }
}

class RewardItem {
  final int? id;
  final String? type;
  final String? periodStartDate;
  final String? periodEndDate;
  final String? name;
  final String? description;
  final int? parentId;
  final int? childrenId;
  final bool? requested;
  final String? redemptionDateTime;
  final bool? approved;
  final int? pointsNeeded;
  final int? missionId;
  final String? condition;
  final int? qtyCondition;
  final int? targetCount;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final User? parent;
  final User? children;
  final ActiveMission? mission;

  RewardItem({
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
    this.status,
    this.createdAt,
    this.updatedAt,
    this.parent,
    this.children,
    this.mission,
  });

  factory RewardItem.fromJson(Map<String, dynamic> json) {
    return RewardItem(
      id: json['id'] as int?,
      type: json['type'] as String?,
      periodStartDate: json['period_start_date'] as String?,
      periodEndDate: json['period_end_date'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      parentId: json['parent_id'] as int?,
      childrenId: json['children_id'] as int?,
      requested: json['requested'] != null ? json['requested'] == 1 : null,
      redemptionDateTime: json['redemption_date_time'] as String?,
      approved: json['approved'] as bool?,
      pointsNeeded: json['points_needed'] as int?,
      missionId: json['mission_id'] as int?,
      condition: json['condition'] as String?,
      qtyCondition: json['qty_condition'] as int? ?? 0,
      targetCount: json['target_count'] as int? ?? 0,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      parent: json['parent'] != null
          ? User.fromJson(json['parent'] as Map<String, dynamic>)
          : null,
      children: json['children'] != null
          ? User.fromJson(json['children'] as Map<String, dynamic>)
          : null,
      mission: json['mission'] != null
          ? ActiveMission.fromJson(json['mission'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'period_start_date': periodStartDate,
      'period_end_date': periodEndDate,
      'name': name,
      'description': description,
      'parent_id': parentId,
      'children_id': childrenId,
      'requested': requested != null ? (requested! ? 1 : 0) : null,
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
      'parent': parent?.toJson(),
      'children': children?.toJson(),
      'mission': mission?.toJson(),
    };
  }
}

class User {
  final int? id;
  final String? username;
  final String? role;

  User({this.id, this.username, this.role});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      username: json['username'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'role': role,
    };
  }
}

class ActiveMission {
  final int? id;
  final String? name;
  final String? description;
  final String? periodeTime;
  final String? startDate;
  final String? endDate;
  final String? type;
  final String? condition;
  final String? appCategory;
  final String? appName;
  final int? missionSuggestionsId;
  final int? parentId;
  final int? childrenId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  ActiveMission({
    this.id,
    this.name,
    this.description,
    this.periodeTime,
    this.startDate,
    this.endDate,
    this.type,
    this.condition,
    this.appCategory,
    this.appName,
    this.missionSuggestionsId,
    this.parentId,
    this.childrenId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory ActiveMission.fromJson(Map<String, dynamic> json) {
    return ActiveMission(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      periodeTime: json['periode_time'] as String?,
      startDate: json['start_date'] as String?,
      endDate: json['end_date'] as String?,
      type: json['type'] as String?,
      condition: json['condition'] as String?,
      appCategory: json['app_category'] as String?,
      appName: json['app_name'] as String?,
      missionSuggestionsId: json['mission_suggestions_id'] as int?,
      parentId: json['parent_id'] as int?,
      childrenId: json['children_id'] as int?,
      status: json['status'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'periode_time': periodeTime,
      'start_date': startDate,
      'end_date': endDate,
      'type': type,
      'condition': condition,
      'app_category': appCategory,
      'app_name': appName,
      'mission_suggestions_id': missionSuggestionsId,
      'parent_id': parentId,
      'children_id': childrenId,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
