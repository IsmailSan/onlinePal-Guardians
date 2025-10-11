import 'dart:convert';

class PunishmentHistoryListResponse {
  final String? status;
  final String? message;
  final PunishmentHistoryListData? data;

  PunishmentHistoryListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory PunishmentHistoryListResponse.fromJson(Map<String, dynamic> json) =>
      PunishmentHistoryListResponse(
        status: json['status'] as String?,
        message: json['message'] as String?,
        data: json['data'] != null
            ? PunishmentHistoryListData.fromJson(json['data'])
            : null,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.toJson(),
      };

  static PunishmentHistoryListResponse fromRawJson(String str) =>
      PunishmentHistoryListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class PunishmentHistoryListData {
  final List<PunishmentHistoryItem>? data;
  final int? nextCursor;

  PunishmentHistoryListData({this.data, this.nextCursor});

  factory PunishmentHistoryListData.fromJson(Map<String, dynamic> json) =>
      PunishmentHistoryListData(
        data: json['data'] != null
            ? List<PunishmentHistoryItem>.from(
                json['data'].map((x) => PunishmentHistoryItem.fromJson(x)))
            : null,
        nextCursor: json['next_cursor'] != null
            ? int.tryParse(json['next_cursor'].toString())
            : null,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.map((x) => x.toJson()).toList(),
        'next_cursor': nextCursor,
      };
}

class PunishmentHistoryItem {
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
  final String? pointsNeeded;
  final int? missionId;
  final String? condition;
  final int? qtyCondition;
  final int? targetCount;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final User? parent;
  final User? children;
  final HistoryMission? mission;

  PunishmentHistoryItem({
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

  factory PunishmentHistoryItem.fromJson(Map<String, dynamic> json) =>
      PunishmentHistoryItem(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        type: json['type'] as String?,
        periodStartDate: json['period_start_date'] as String?,
        periodEndDate: json['period_end_date'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        parentId: json['parent_id'] != null
            ? int.tryParse(json['parent_id'].toString())
            : null,
        childrenId: json['children_id'] != null
            ? int.tryParse(json['children_id'].toString())
            : null,
        requested: json['requested'] != null
            ? (json['requested'] == 1 || json['requested'] == true)
            : null,
        redemptionDateTime: json['redemption_date_time'] as String?,
        approved: json['approved'] as bool?,
        pointsNeeded: json['points_needed'] as String?,
        missionId: json['mission_id'] != null
            ? int.tryParse(json['mission_id'].toString())
            : null,
        condition: json['condition'] as String?,
        qtyCondition: json['qty_condition'] != null
            ? int.tryParse(json['qty_condition'].toString())
            : null,
        targetCount: json['target_count'] != null
            ? int.tryParse(json['target_count'].toString())
            : null,
        status: json['status'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        parent: json['parent'] != null ? User.fromJson(json['parent']) : null,
        children:
            json['children'] != null ? User.fromJson(json['children']) : null,
        mission: json['mission'] != null
            ? HistoryMission.fromJson(json['mission'])
            : null,
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
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'parent': parent?.toJson(),
        'children': children?.toJson(),
        'mission': mission?.toJson(),
      };
}

class User {
  final int? id;
  final String? username;
  final String? role;

  User({this.id, this.username, this.role});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        username: json['username'] as String?,
        role: json['role'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'role': role,
      };
}

class HistoryMission {
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

  HistoryMission({
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

  factory HistoryMission.fromJson(Map<String, dynamic> json) => HistoryMission(
        id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
        name: json['name'] as String?,
        description: json['description'] as String?,
        periodeTime: json['periode_time'] as String?,
        startDate: json['start_date'] as String?,
        endDate: json['end_date'] as String?,
        type: json['type'] as String?,
        condition: json['condition'] as String?,
        appCategory: json['app_category'] as String?,
        appName: json['app_name'] as String?,
        missionSuggestionsId: json['mission_suggestions_id'] != null
            ? int.tryParse(json['mission_suggestions_id'].toString())
            : null,
        parentId: json['parent_id'] != null
            ? int.tryParse(json['parent_id'].toString())
            : null,
        childrenId: json['children_id'] != null
            ? int.tryParse(json['children_id'].toString())
            : null,
        status: json['status'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
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
