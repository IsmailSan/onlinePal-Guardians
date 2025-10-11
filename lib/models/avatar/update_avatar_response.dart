import 'dart:convert';

class UpdateAvatarResponse {
  final String status;
  final String message;
  final UpdateAvatarData? data;

  UpdateAvatarResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory UpdateAvatarResponse.fromJson(Map<String, dynamic> json) {
    return UpdateAvatarResponse(
      status: json['status'],
      message: json['message'],
      data:
          json['data'] != null ? UpdateAvatarData.fromJson(json['data']) : null,
    );
  }

  static UpdateAvatarResponse fromRawJson(String str) =>
      UpdateAvatarResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode({
        'status': status,
        'message': message,
        'data': data?.toJson(),
      });
}

class UpdateAvatarData {
  final int? id;
  final String? name;
  final String? dateOfBirth;
  final String? gender;
  final String? liveWithParents;
  final String? grade;
  final String? school;
  final List<String> favoritePhysicalActivities;
  final List<String> hobbies;
  final List<String> favoriteFamilyActivities;
  final List<String> favoriteOnlineActivities;
  final int? userId;
  final int? parentId;
  final int? avatarId;
  final User? user;
  final Avatar? avatar;

  UpdateAvatarData({
    this.id,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.liveWithParents,
    this.grade,
    this.school,
    required this.favoritePhysicalActivities,
    required this.hobbies,
    required this.favoriteFamilyActivities,
    required this.favoriteOnlineActivities,
    this.userId,
    this.parentId,
    this.avatarId,
    this.user,
    this.avatar,
  });

  factory UpdateAvatarData.fromJson(Map<String, dynamic> json) {
    return UpdateAvatarData(
      id: json['id'],
      name: json['name'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      liveWithParents: json['live_with_parents'],
      grade: json['grade'],
      school: json['school'],
      favoritePhysicalActivities: json['favorite_physical_activities'] != null
          ? List<String>.from(json['favorite_physical_activities'])
          : [],
      hobbies:
          json['hobbies'] != null ? List<String>.from(json['hobbies']) : [],
      favoriteFamilyActivities: json['favorite_family_activities'] != null
          ? List<String>.from(json['favorite_family_activities'])
          : [],
      favoriteOnlineActivities: json['favorite_online_activities'] != null
          ? List<String>.from(json['favorite_online_activities'])
          : [],
      userId: json['user_id'],
      parentId: json['parent_id'],
      avatarId: json['avatar_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
    );
  }

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
        'user': user?.toJson(),
        'avatar': avatar?.toJson(),
      };
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

  factory Avatar.fromJson(Map<String, dynamic> json) => Avatar(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        role: json['role'],
        gender: json['gender'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        imageUrl: json['image_url'],
      );

  Map<String, dynamic> toJson() => {
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
