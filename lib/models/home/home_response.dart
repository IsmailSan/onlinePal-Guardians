class HomeResponse {
  final String status;
  final String message;
  final List<HomeData> data;

  HomeResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory HomeResponse.fromJson(Map<String, dynamic> json) {
    return HomeResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HomeData.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((e) => e.toJson()).toList(),
    };
  }
}

class HomeData {
  final Avatar? profile;
  final ChildData? child;
  final List<Mission>? missionsToday;
  final List<Schedule>? schedulesToday;

  HomeData({
    this.profile,
    this.child,
    this.missionsToday,
    this.schedulesToday,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    return HomeData(
      profile: json['profile'] != null ? Avatar.fromJson(json['profile']) : null,
      child: json['child'] != null ? ChildData.fromJson(json['child']) : null,
      missionsToday: (json['missions_today'] as List<dynamic>?)
          ?.map((e) => Mission.fromJson(e))
          .toList() ??
          [],
      schedulesToday: (json['schedules_today'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'profile': profile?.toJson(),
      'child': child?.toJson(),
      'missions_today': missionsToday?.map((e) => e.toJson()).toList(),
      'schedules_today': schedulesToday?.map((e) => e.toJson()).toList(),
    };
  }
}

class Avatar {
  final int? id;
  final String? name;
  final String? image;
  final String? role;
  final String? gender;
  final String? createdAt;
  final String? updatedAt;
  final String? imageUrl;

  Avatar({
    this.id,
    this.name,
    this.image,
    this.role,
    this.gender,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      role: json['role'],
      gender: json['gender'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'role': role,
      'gender': gender,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'image_url': imageUrl,
    };
  }
}

class ChildData {
  final int? id;
  final String? username;
  final String? role;
  final Point? points;
  final ChildrenProfile? childrenProfile;

  ChildData({
    this.id,
    this.username,
    this.role,
    this.points,
    this.childrenProfile,
  });

  factory ChildData.fromJson(Map<String, dynamic> json) {
    return ChildData(
      id: json['id'],
      username: json['username'],
      role: json['role'],
      points: json['points'] != null ? Point.fromJson(json['points']) : null,
      childrenProfile: json['children_profile'] != null
          ? ChildrenProfile.fromJson(json['children_profile'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'role': role,
      'points': points?.toJson(),
      'children_profile': childrenProfile?.toJson(),
    };
  }
}

class Point {
  final int? id;
  final int? userId;
  final int? point;
  final String? createdAt;
  final String? updatedAt;

  Point({this.id, this.userId, this.point, this.createdAt, this.updatedAt});

  factory Point.fromJson(Map<String, dynamic> json) => Point(
    id: json['id'],
    userId: json['user_id'],
    point: json['point'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'point': point,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

class ChildrenProfile {
  final int? id;
  final String? name;
  final String? dateOfBirth;
  final String? gender;
  final String? liveWithParents;
  final String? grade;
  final String? school;
  final List<String>? favoritePhysicalActivities;
  final List<String>? hobbies;
  final List<String>? favoriteFamilyActivities;
  final List<String>? favoriteOnlineActivities;
  final int? userId;
  final int? parentId;
  final int? avatarId;

  ChildrenProfile({
    this.id,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.liveWithParents,
    this.grade,
    this.school,
    this.favoritePhysicalActivities,
    this.hobbies,
    this.favoriteFamilyActivities,
    this.favoriteOnlineActivities,
    this.userId,
    this.parentId,
    this.avatarId,
  });

  factory ChildrenProfile.fromJson(Map<String, dynamic> json) => ChildrenProfile(
    id: json['id'],
    name: json['name'],
    dateOfBirth: json['date_of_birth'],
    gender: json['gender'],
    liveWithParents: json['live_with_parents'],
    grade: json['grade'],
    school: json['school'],
    favoritePhysicalActivities:
    List<String>.from(json['favorite_physical_activities'] ?? []),
    hobbies: List<String>.from(json['hobbies'] ?? []),
    favoriteFamilyActivities:
    List<String>.from(json['favorite_family_activities'] ?? []),
    favoriteOnlineActivities:
    List<String>.from(json['favorite_online_activities'] ?? []),
    userId: json['user_id'],
    parentId: json['parent_id'],
    avatarId: json['avatar_id'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'date_of_birth': dateOfBirth,
    'gender': gender,
    'live_with_parents': liveWithParents,
    'grade': grade,
    'school': school,
    'favorite_physical_activities': favoritePhysicalActivities,
    'hobbies': hobbies,
    'favorite_family_activities': favoriteFamilyActivities,
    'favorite_online_activities': favoriteOnlineActivities,
    'user_id': userId,
    'parent_id': parentId,
    'avatar_id': avatarId,
  };
}

class Mission {
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

  Mission({
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

  factory Mission.fromJson(Map<String, dynamic> json) => Mission(
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

class Schedule {
  final int? id;
  final String? date;
  final String? timeStart;
  final String? timeEnd;
  final int? scheduleItemId;
  final String? customName;
  final String? customCategory;
  final String? customIcon;
  final String? customColor;
  final String? notes;
  final int? createdById;
  final int? childrenId;
  final String? createdAt;
  final String? updatedAt;

  Schedule({
    this.id,
    this.date,
    this.timeStart,
    this.timeEnd,
    this.scheduleItemId,
    this.customName,
    this.customCategory,
    this.customIcon,
    this.customColor,
    this.notes,
    this.createdById,
    this.childrenId,
    this.createdAt,
    this.updatedAt,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
    id: json['id'],
    date: json['date'],
    timeStart: json['time_start'],
    timeEnd: json['time_end'],
    scheduleItemId: json['schedule_item_id'],
    customName: json['custom_name'],
    customCategory: json['custom_category'],
    customIcon: json['custom_icon'],
    customColor: json['custom_color'],
    notes: json['notes'],
    createdById: json['created_by_id'],
    childrenId: json['children_id'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'time_start': timeStart,
    'time_end': timeEnd,
    'schedule_item_id': scheduleItemId,
    'custom_name': customName,
    'custom_category': customCategory,
    'custom_icon': customIcon,
    'custom_color': customColor,
    'notes': notes,
    'created_by_id': createdById,
    'children_id': childrenId,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}
