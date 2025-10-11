import 'dart:convert';

class ActivePunishmentListResponse {
  final String? status;
  final String? message;
  final PunishmentListData? data;

  ActivePunishmentListResponse({this.status, this.message, this.data});

  factory ActivePunishmentListResponse.fromJson(Map<String, dynamic> json) {
    return ActivePunishmentListResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? PunishmentListData.fromJson(json['data'] as Map<String, dynamic>)
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

  static ActivePunishmentListResponse fromRawJson(String str) =>
      ActivePunishmentListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class PunishmentListData {
  final List<PunishmentItem>? data;
  final int? nextCursor;

  PunishmentListData({this.data, this.nextCursor});

  factory PunishmentListData.fromJson(Map<String, dynamic> json) {
    return PunishmentListData(
      data: json['data'] != null
          ? List<PunishmentItem>.from(
              (json['data'] as List).map((x) => PunishmentItem.fromJson(x)))
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

class PunishmentItem {
  final int? id;
  final int? missionId;
  final String? periodStartDate;
  final String? periodEndDate;
  final String? condition;
  final int? qtyCondition;
  final int? pointReduction;
  final String? name;
  final String? description;
  final int? parentId;
  final int? childrenId;
  final int? targetCount;
  final String? status;
  final String? punishmentDate;
  final String? createdAt;
  final String? updatedAt;
  final User? parent;
  final User? children;
  final PunishmentMission? mission;

  PunishmentItem({
    this.id,
    this.missionId,
    this.periodStartDate,
    this.periodEndDate,
    this.condition,
    this.qtyCondition,
    this.pointReduction,
    this.name,
    this.description,
    this.parentId,
    this.childrenId,
    this.targetCount,
    this.status,
    this.punishmentDate,
    this.createdAt,
    this.updatedAt,
    this.parent,
    this.children,
    this.mission,
  });

  factory PunishmentItem.fromJson(Map<String, dynamic> json) {
    return PunishmentItem(
      id: json['id'] as int?,
      missionId: json['mission_id'] as int?,
      periodStartDate: json['period_start_date'] as String?,
      periodEndDate: json['period_end_date'] as String?,
      condition: json['condition'] as String?,
      qtyCondition: json['qty_condition'] as int? ?? 0,
      pointReduction: json['point_reduction'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      parentId: json['parent_id'] as int?,
      childrenId: json['children_id'] as int?,
      targetCount: json['target_count'] as int? ?? 0,
      status: json['status'] as String?,
      punishmentDate: json['punishment_date'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      parent: json['parent'] != null
          ? User.fromJson(json['parent'] as Map<String, dynamic>)
          : null,
      children: json['children'] != null
          ? User.fromJson(json['children'] as Map<String, dynamic>)
          : null,
      mission: json['mission'] != null
          ? PunishmentMission.fromJson(json['mission'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mission_id': missionId,
      'period_start_date': periodStartDate,
      'period_end_date': periodEndDate,
      'condition': condition,
      'qty_condition': qtyCondition,
      'point_reduction': pointReduction,
      'name': name,
      'description': description,
      'parent_id': parentId,
      'children_id': childrenId,
      'target_count': targetCount,
      'status': status,
      'punishment_date': punishmentDate,
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

class PunishmentMission {
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

  PunishmentMission({
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

  factory PunishmentMission.fromJson(Map<String, dynamic> json) {
    return PunishmentMission(
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
