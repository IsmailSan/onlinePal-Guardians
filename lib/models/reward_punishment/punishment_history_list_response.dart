import 'dart:convert';

class PunishmentHistoryListResponse {
  final String status;
  final String message;
  final PunishmentHistoryListData data;

  PunishmentHistoryListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PunishmentHistoryListResponse.fromJson(Map<String, dynamic> json) =>
      PunishmentHistoryListResponse(
        status: json['status'],
        message: json['message'],
        data: PunishmentHistoryListData.fromJson(json['data']),
      );

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };

  static PunishmentHistoryListResponse fromRawJson(String str) =>
      PunishmentHistoryListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class PunishmentHistoryListData {
  final List<PunishmentHistoryItem> data;
  final int? nextCursor;

  PunishmentHistoryListData({
    required this.data,
    required this.nextCursor,
  });

  factory PunishmentHistoryListData.fromJson(Map<String, dynamic> json) => PunishmentHistoryListData(
    data: List<PunishmentHistoryItem>.from(
        json['data'].map((x) => PunishmentHistoryItem.fromJson(x))),
    nextCursor: json['next_cursor'],
  );

  Map<String, dynamic> toJson() => {
    'data': List<dynamic>.from(data.map((x) => x.toJson())),
    'next_cursor': nextCursor,
  };
}

class PunishmentHistoryItem {
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
  final User parent;
  final User children;
  final HistoryMission? mission;

  PunishmentHistoryItem({
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
    required this.parent,
    required this.children,
    required this.mission,
  });

  factory PunishmentHistoryItem.fromJson(Map<String, dynamic> json) => PunishmentHistoryItem(
    id: json['id'],
    type: json['type'],
    periodStartDate: json['period_start_date'],
    periodEndDate: json['period_end_date'],
    name: json['name'],
    description: json['description'],
    parentId: json['parent_id'],
    childrenId: json['children_id'],
    requested: json['requested'] == 1,
    redemptionDateTime: json['redemption_date_time'],
    approved: json['approved'],
    pointsNeeded: json['points_needed'],
    missionId: json['mission_id'],
    condition: json['condition'],
    qtyCondition: json['qty_condition'],
    targetCount: json['target_count'],
    status: json['status'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
    parent: User.fromJson(json['parent']),
    children: User.fromJson(json['children']),
    mission: json['mission'] != null ? HistoryMission.fromJson(json['mission']) : null,
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

class HistoryMission {
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

  HistoryMission({
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

  factory HistoryMission.fromJson(Map<String, dynamic> json) => HistoryMission(
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
