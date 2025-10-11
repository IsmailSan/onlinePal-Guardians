class GetProfileResponse {
  final String? status;
  final String? message;
  final ParentProfile? data;

  GetProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ParentProfile.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class ParentProfile {
  final int? id;
  final int? userId;
  final String? name;
  final String? dateOfBirth;
  final String? gender;
  final String? nationality;
  final String? province;
  final String? city;
  final String? postalCode;
  final String? occupation;
  final String? rangeOfFamilyIncome;
  final int? numberOfChildren;
  final int? avatarId;
  final Avatar? avatars;

  ParentProfile({
    this.id,
    this.userId,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.nationality,
    this.province,
    this.city,
    this.postalCode,
    this.occupation,
    this.rangeOfFamilyIncome,
    this.numberOfChildren,
    this.avatarId,
    this.avatars,
  });

  factory ParentProfile.fromJson(Map<String, dynamic> json) {
    return ParentProfile(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      name: json['name'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      nationality: json['nationality'] as String?,
      province: json['province'] as String?,
      city: json['city'] as String?,
      postalCode: json['postal_code'] as String?,
      occupation: json['occupation'] as String?,
      rangeOfFamilyIncome: json['range_of_family_income'] as String?,
      numberOfChildren: json['number_of_children'] as int?,
      avatarId: json['avatar_id'] as int?,
      avatars: json['avatars'] != null
          ? Avatar.fromJson(json['avatars'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'nationality': nationality,
      'province': province,
      'city': city,
      'postal_code': postalCode,
      'occupation': occupation,
      'range_of_family_income': rangeOfFamilyIncome,
      'number_of_children': numberOfChildren,
      'avatar_id': avatarId,
      'avatars': avatars?.toJson(),
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
      id: json['id'] as int?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      role: json['role'] as String?,
      gender: json['gender'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      imageUrl: json['image_url'] as String?,
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
