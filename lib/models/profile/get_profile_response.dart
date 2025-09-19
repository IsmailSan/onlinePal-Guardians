class GetProfileResponse {
  final String status;
  final String message;
  final ParentProfile data;

  GetProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) {
    return GetProfileResponse(
      status: json['status'],
      message: json['message'],
      data: ParentProfile.fromJson(json['data']),
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

class ParentProfile {
  final int id;
  final int userId;
  final String name;
  final String dateOfBirth;
  final String gender;
  final String nationality;
  final String province;
  final String city;
  final String postalCode;
  final String occupation;
  final String rangeOfFamilyIncome;
  final int numberOfChildren;
  final int? avatarId;
  final Avatar? avatars;

  ParentProfile({
    required this.id,
    required this.userId,
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.nationality,
    required this.province,
    required this.city,
    required this.postalCode,
    required this.occupation,
    required this.rangeOfFamilyIncome,
    required this.numberOfChildren,
    this.avatarId,
    this.avatars,
  });

  factory ParentProfile.fromJson(Map<String, dynamic> json) {
    return ParentProfile(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      nationality: json['nationality'],
      province: json['province'],
      city: json['city'],
      postalCode: json['postal_code'],
      occupation: json['occupation'],
      rangeOfFamilyIncome: json['range_of_family_income'],
      numberOfChildren: json['number_of_children'],
      avatarId: json['avatar_id'],
      avatars: json['avatars'] != null ? Avatar.fromJson(json['avatars']) : null,
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
