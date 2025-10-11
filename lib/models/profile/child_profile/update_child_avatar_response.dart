import 'dart:convert';

class UpdateChildAvatarResponse {
  final String? status;
  final String? message;
  final UpdateAvatarData? data;

  UpdateChildAvatarResponse({
    this.status,
    this.message,
    this.data,
  });

  factory UpdateChildAvatarResponse.fromJson(Map<String, dynamic> json) {
    return UpdateChildAvatarResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? UpdateAvatarData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  static UpdateChildAvatarResponse fromRawJson(String str) =>
      UpdateChildAvatarResponse.fromJson(
          json.decode(str) as Map<String, dynamic>);

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
  final List<String>? favoritePhysicalActivities;
  final List<String>? hobbies;
  final List<String>? favoriteFamilyActivities;
  final List<String>? favoriteOnlineActivities;
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

  factory UpdateAvatarData.fromJson(Map<String, dynamic> json) {
    return UpdateAvatarData(
      id: json['id'] as int?,
      name: json['name'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      liveWithParents: json['live_with_parents'] as String?,
      grade: json['grade'] as String?,
      school: json['school'] as String?,
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
      userId: json['user_id'] as int?,
      parentId: json['parent_id'] as int?,
      avatarId: json['avatar_id'] as int?,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      avatar: json['avatar'] != null
          ? Avatar.fromJson(json['avatar'] as Map<String, dynamic>)
          : null,
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

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      username: json['username'] as String?,
      role: json['role'] as String?,
    );
  }

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
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        role: json['role'] as String?,
        gender: json['gender'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
        imageUrl: json['image_url'] as String?,
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
