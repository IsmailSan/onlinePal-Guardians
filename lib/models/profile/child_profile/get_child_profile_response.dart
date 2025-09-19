class GetChildProfileResponse {
  final String status;
  final String message;
  final ChildProfile data;

  GetChildProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetChildProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetChildProfileResponse(
      status: json['status'],
      message: json['message'],
      data: ChildProfile.fromJson(json['data']),
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


class ChildProfile {
  final int id;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String liveWithParents;
  final String grade;
  final String school;
  final List<dynamic> favoritePhysicalActivities;
  final List<dynamic> hobbies;
  final List<dynamic> favoriteFamilyActivities;
  final List<dynamic> favoriteOnlineActivities;
  final int userId;
  final int parentId;
  final int? avatarId;
  final User? user;
  final Avatar? avatar;

  ChildProfile({
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

  factory ChildProfile.fromJson(Map<String, dynamic> json) {
    return ChildProfile(
      id: json['id'],
      name: json['name'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      liveWithParents: json['live_with_parents'],
      grade: json['grade'],
      school: json['school'],
      favoritePhysicalActivities: List<dynamic>.from(json['favorite_physical_activities'] ?? []),
      hobbies: List<dynamic>.from(json['hobbies'] ?? []),
      favoriteFamilyActivities: List<dynamic>.from(json['favorite_family_activities'] ?? []),
      favoriteOnlineActivities: List<dynamic>.from(json['favorite_online_activities'] ?? []),
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


class Avatar {
  final int id;
  final String name;
  final String image;
  final String role;
  final String gender;
  final String? createdAt;
  final String? updatedAt;
  final String imageUrl;

  Avatar({
    required this.id,
    required this.name,
    required this.image,
    required this.role,
    required this.gender,
    this.createdAt,
    this.updatedAt,
    required this.imageUrl,
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
