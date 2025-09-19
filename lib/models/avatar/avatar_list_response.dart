class AvatarListResponse {
  final String status;
  final String message;
  final List<Avatar> data;

  AvatarListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AvatarListResponse.fromJson(Map<String, dynamic> json) {
    return AvatarListResponse(
      status: json['status'] as String,
      message: json['message'] as String,
      data: (json['data'] as List)
          .map((item) => Avatar.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((avatar) => avatar.toJson()).toList(),
    };
  }
}

class Avatar {
  final int id;
  final String? name;
  final String? image;
  final String? role;
  final String? gender;
  final String? createdAt;
  final String? updatedAt;
  final String? imageUrl;

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
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      role: json['role'] as String,
      gender: json['gender'] as String,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      imageUrl: json['image_url'] as String,
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
