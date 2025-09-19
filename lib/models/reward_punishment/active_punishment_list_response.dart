import 'dart:convert';

class ActivePunishmentListResponse {
  final String status;
  final String message;
  final PunishmentListData data;

  ActivePunishmentListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ActivePunishmentListResponse.fromJson(Map<String, dynamic> json) =>
      ActivePunishmentListResponse(
        status: json['status'],
        message: json['message'],
        data: PunishmentListData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };

  static ActivePunishmentListResponse fromRawJson(String str) =>
      ActivePunishmentListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class PunishmentListData {
  final List<PunishmentItem> data;
  final int? nextCursor;

  PunishmentListData({
    required this.data,
    required this.nextCursor,
  });

  factory PunishmentListData.fromJson(Map<String, dynamic> json) => PunishmentListData(
    data: List<PunishmentItem>.from(
        json['data'].map((x) => PunishmentItem.fromJson(x))),
    nextCursor: json['next_cursor'],
  );

  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
    'next_cursor': nextCursor,
  };
}

class PunishmentItem {
  final int id;
  final int? missionId;
  final String periodStartDate;
  final String periodEndDate;
  final String? condition;
  final int qtyCondition;
  final int? pointReduction;
  final String name;
  final String? description;
  final int parentId;
  final int childrenId;
  final int targetCount;
  final String status;
  final String? punishmentDate;
  final String createdAt;
  final String updatedAt;
  final User parent;
  final User children;
  final PunishmentMission? mission;

  PunishmentItem({
    required this.id,
    required this.missionId,
    required this.periodStartDate,
    required this.periodEndDate,
    required this.condition,
    required this.qtyCondition,
    required this.pointReduction,
    required this.name,
    required this.description,
    required this.parentId,
    required this.childrenId,
    required this.targetCount,
    required this.status,
    required this.punishmentDate,
    required this.createdAt,
    required this.updatedAt,
    required this.parent,
    required this.children,
    required this.mission,
  });

  factory PunishmentItem.fromJson(Map<String, dynamic> json) {
    return PunishmentItem(
      id: json['id'],
      missionId: json['mission_id'],
      periodStartDate: json['period_start_date'],
      periodEndDate: json['period_end_date'],
      condition: json['condition'],
      qtyCondition: json['qty_condition'] ?? 0,
      pointReduction: json['point_reduction'],
      name: json['name'],
      description: json['description'],
      parentId: json['parent_id'],
      childrenId: json['children_id'],
      targetCount: json['target_count'] ?? 0,
      status: json['status'],
      punishmentDate: json['punishment_date'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      parent: User.fromJson(json['parent']),
      children: User.fromJson(json['children']),
      mission: json['mission'] != null ? PunishmentMission.fromJson(json['mission']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
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
    'parent': parent.toJson(),
    'children': children.toJson(),
    'mission': mission?.toJson(),
  };
}

class User {
  final int id;
  final String username;
  final String role;

  User({
    required this.id,
    required this.username,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    role: json['role'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'role': role,
  };
}

class PunishmentMission {
  final int id;
  final String name;
  final String description;
  final String periodeTime;
  final String? startDate;
  final String? endDate;
  final String type;
  final String condition;
  final String appCategory;
  final String appName;
  final int missionSuggestionsId;
  final int parentId;
  final int childrenId;
  final String status;
  final String createdAt;
  final String updatedAt;

  PunishmentMission({
    required this.id,
    required this.name,
    required this.description,
    required this.periodeTime,
    required this.startDate,
    required this.endDate,
    required this.type,
    required this.condition,
    required this.appCategory,
    required this.appName,
    required this.missionSuggestionsId,
    required this.parentId,
    required this.childrenId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PunishmentMission.fromJson(Map<String, dynamic> json) => PunishmentMission(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    periodeTime: json['periode_time'],
    startDate: json['start_date'],
    endDate: json['end_date'],
    type: json['type'],
    condition: json['condition'],
    appCategory: json['app_category'],
    appName: json['app_name'],
    missionSuggestionsId: json['mission_suggestions_id'],
    parentId: json['parent_id'],
    childrenId: json['children_id'],
    status: json['status'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
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
