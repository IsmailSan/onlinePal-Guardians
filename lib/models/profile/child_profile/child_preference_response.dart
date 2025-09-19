class ChildPreferenceResponse {
  final String status;
  final String message;
  final ChildPreference data;

  ChildPreferenceResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ChildPreferenceResponse.fromJson(Map<String, dynamic> json) {
    return ChildPreferenceResponse(
      status: json['status'],
      message: json['message'],
      data: ChildPreference.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.toJson(),
    };
  }
}

class ChildPreference {
  final int id;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String liveWithParents;
  final String grade;
  final String school;
  final List<String> favoritePhysicalActivities;
  final List<String> hobbies;
  final List<String> favoriteFamilyActivities;
  final List<String> favoriteOnlineActivities;
  final int userId;
  final int parentId;
  final int? avatarId;
  final User? user;
  final dynamic avatar;

  ChildPreference({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.liveWithParents,
    required this.grade,
    required this.school,
    required this.favoritePhysicalActivities,
    required this.hobbies,
    required this.favoriteFamilyActivities,
    required this.favoriteOnlineActivities,
    required this.userId,
    required this.parentId,
    this.avatarId,
    this.user,
    this.avatar,
  });

  factory ChildPreference.fromJson(Map<String, dynamic> json) {
    return ChildPreference(
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
      user: json['user'] != null ? User.fromJson(json['user']) : null,
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
  final int id;
  final String username;
  final String role;

  User({
    required this.id,
    required this.username,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      role: json['role'],
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
