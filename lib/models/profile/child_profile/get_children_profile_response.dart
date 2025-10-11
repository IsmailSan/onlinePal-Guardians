class GetChildrenProfileResponse {
  final String? status;
  final String? message;
  final List<ChildProfile>? data;

  GetChildrenProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetChildrenProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetChildrenProfileResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? List<ChildProfile>.from(
              (json['data'] as List).map(
                (item) => ChildProfile.fromJson(item as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }
}

class ChildProfile {
  final int? id;
  final String? name;
  final String? dateOfBirth;
  final String? gender;
  final String? liveWithParents;
  final String? grade;
  final String? school;
  final List<dynamic>? favoritePhysicalActivities;
  final List<dynamic>? hobbies;
  final List<dynamic>? favoriteFamilyActivities;
  final List<dynamic>? favoriteOnlineActivities;
  final int? userId;
  final int? parentId;
  final int? avatarId;
  final User? user;
  final dynamic avatar;

  ChildProfile({
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
    this.user,
    this.avatar,
  });

  factory ChildProfile.fromJson(Map<String, dynamic> json) {
    return ChildProfile(
      id: json['id'] as int?,
      name: json['name'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      liveWithParents: json['live_with_parents'] as String?,
      grade: json['grade'] as String?,
      school: json['school'] as String?,
      favoritePhysicalActivities: json['favorite_physical_activities'] != null
          ? List<dynamic>.from(json['favorite_physical_activities'])
          : [],
      hobbies:
          json['hobbies'] != null ? List<dynamic>.from(json['hobbies']) : [],
      favoriteFamilyActivities: json['favorite_family_activities'] != null
          ? List<dynamic>.from(json['favorite_family_activities'])
          : [],
      favoriteOnlineActivities: json['favorite_online_activities'] != null
          ? List<dynamic>.from(json['favorite_online_activities'])
          : [],
      userId: json['user_id'] as int?,
      parentId: json['parent_id'] as int?,
      avatarId: json['avatar_id'] as int?,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      avatar: json['avatar'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'user': user?.toJson(),
      'avatar': avatar,
    };
  }
}

class User {
  final int? id;
  final String? username;
  final String? role;

  User({
    this.id,
    this.username,
    this.role,
  });

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
