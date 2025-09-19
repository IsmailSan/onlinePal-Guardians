class NotificationListResponse {
  final String? status;
  final String? message;
  final NotificationData? data;

  NotificationListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory NotificationListResponse.fromJson(Map<String, dynamic> json) {
    return NotificationListResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? NotificationData.fromJson(json['data'])
          : null,
    );
  }
}

class NotificationData {
  final Map<String, List<NotificationItem>>? data;
  final dynamic nextCursor;

  NotificationData({
    this.data,
    this.nextCursor,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    Map<String, List<NotificationItem>>? parsedData;

    if (json['data'] is Map<String, dynamic>) {
      final rawData = json['data'] as Map<String, dynamic>;
      parsedData = rawData.map((key, value) {
        final list = (value as List<dynamic>)
            .map((e) => NotificationItem.fromJson(e))
            .toList();
        return MapEntry(key, list);
      });
    }

    return NotificationData(
      data: parsedData,
      nextCursor: json['next_cursor'],
    );
  }
}

class NotificationItem {
  final int? id;
  final String? title;
  final String? type;
  final NotificationDetail? data;
  final String? notifiedAt;
  final bool? read;

  NotificationItem({
    this.id,
    this.title,
    this.type,
    this.data,
    this.notifiedAt,
    this.read,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      title: json['title'],
      type: json['type'],
      data: json['data'] != null
          ? NotificationDetail.fromJson(json['data'])
          : null,
      notifiedAt: json['notified_at'],
      read: json['read'],
    );
  }
}

class NotificationDetail {
  final MissionDataWrapper? data;
  final String? date;

  NotificationDetail({
    this.data,
    this.date,
  });

  factory NotificationDetail.fromJson(Map<String, dynamic> json) {
    return NotificationDetail(
      data: json['data'] != null
          ? MissionDataWrapper.fromJson(json['data'])
          : null,
      date: json['date'],
    );
  }
}

class MissionDataWrapper {
  final int? id;
  final String? name;
  final String? type;
  final String? status;
  final String? appName;
  final ChildData? children;
  final String? endDate;
  final String? condition;
  final int? parentId;
  final String? createdAt;
  final String? startDate;
  final String? updatedAt;
  final int? childrenId;
  final String? description;
  final String? appCategory;
  final String? periodeTime;
  final dynamic directReward;
  final dynamic pointAddition;
  final dynamic pointDeduction;
  final dynamic directPunishment;
  final int? missionSuggestionsId;

  MissionDataWrapper({
    this.id,
    this.name,
    this.type,
    this.status,
    this.appName,
    this.children,
    this.endDate,
    this.condition,
    this.parentId,
    this.createdAt,
    this.startDate,
    this.updatedAt,
    this.childrenId,
    this.description,
    this.appCategory,
    this.periodeTime,
    this.directReward,
    this.pointAddition,
    this.pointDeduction,
    this.directPunishment,
    this.missionSuggestionsId,
  });

  factory MissionDataWrapper.fromJson(Map<String, dynamic> json) {
    return MissionDataWrapper(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      status: json['status'],
      appName: json['app_name'],
      children: json['children'] != null
          ? ChildData.fromJson(json['children'])
          : null,
      endDate: json['end_date'],
      condition: json['condition'],
      parentId: json['parent_id'],
      createdAt: json['created_at'],
      startDate: json['start_date'],
      updatedAt: json['updated_at'],
      childrenId: json['children_id'],
      description: json['description'],
      appCategory: json['app_category'],
      periodeTime: json['periode_time'],
      directReward: json['direct_reward'],
      pointAddition: json['point_addition'],
      pointDeduction: json['point_deduction'],
      directPunishment: json['direct_punishment'],
      missionSuggestionsId: json['mission_suggestions_id'],
    );
  }
}

class ChildData {
  final int? id;
  final String? role;
  final String? username;
  final ChildProfile? childrenProfile;

  ChildData({
    this.id,
    this.role,
    this.username,
    this.childrenProfile,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) {
    return ChildData(
      id: json['id'],
      role: json['role'],
      username: json['username'],
      childrenProfile: json['children_profile'] != null
          ? ChildProfile.fromJson(json['children_profile'])
          : null,
    );
  }
}

class ChildProfile {
  final int? id;
  final String? name;
  final String? grade;
  final String? gender;
  final String? school;
  final List<String>? hobbies;
  final int? userId;
  final int? avatarId;
  final int? parentId;
  final String? dateOfBirth;
  final String? liveWithParents;
  final List<String>? favoriteFamilyActivities;
  final List<String>? favoriteOnlineActivities;
  final List<String>? favoritePhysicalActivities;

  ChildProfile({
    this.id,
    this.name,
    this.grade,
    this.gender,
    this.school,
    this.hobbies,
    this.userId,
    this.avatarId,
    this.parentId,
    this.dateOfBirth,
    this.liveWithParents,
    this.favoriteFamilyActivities,
    this.favoriteOnlineActivities,
    this.favoritePhysicalActivities,
  });

  factory ChildProfile.fromJson(Map<String, dynamic> json) {
    return ChildProfile(
      id: json['id'],
      name: json['name'],
      grade: json['grade'],
      gender: json['gender'],
      school: json['school'],
      hobbies: List<String>.from(json['hobbies'] ?? []),
      userId: json['user_id'],
      avatarId: json['avatar_id'],
      parentId: json['parent_id'],
      dateOfBirth: json['date_of_birth'],
      liveWithParents: json['live_with_parents'],
      favoriteFamilyActivities:
      List<String>.from(json['favorite_family_activities'] ?? []),
      favoriteOnlineActivities:
      List<String>.from(json['favorite_online_activities'] ?? []),
      favoritePhysicalActivities:
      List<String>.from(json['favorite_physical_activities'] ?? []),
    );
  }
}
