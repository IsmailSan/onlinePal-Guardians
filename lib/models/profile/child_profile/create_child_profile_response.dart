class CreateChildProfileResponse {
  final String? status;
  final String? message;
  final ChildProfile? data;

  CreateChildProfileResponse({
    this.status,
    this.message,
    this.data,
  });

  factory CreateChildProfileResponse.fromJson(Map<String, dynamic> json) {
    return CreateChildProfileResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? ChildProfile.fromJson(json['data'] as Map<String, dynamic>)
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

class ChildProfile {
  final String? name;
  final String? dateOfBirth;
  final String? gender;
  final String? liveWithParents;
  final String? grade;
  final String? school;
  final int? userId;
  final int? parentId;
  final int? id;

  ChildProfile({
    this.name,
    this.dateOfBirth,
    this.gender,
    this.liveWithParents,
    this.grade,
    this.school,
    this.userId,
    this.parentId,
    this.id,
  });

  factory ChildProfile.fromJson(Map<String, dynamic> json) {
    return ChildProfile(
      name: json['name'] as String?,
      dateOfBirth: json['date_of_birth'] as String?,
      gender: json['gender'] as String?,
      liveWithParents: json['live_with_parents'] as String?,
      grade: json['grade'] as String?,
      school: json['school'] as String?,
      userId: json['user_id'] as int?,
      parentId: json['parent_id'] as int?,
      id: json['id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'date_of_birth': dateOfBirth,
      'gender': gender,
      'live_with_parents': liveWithParents,
      'grade': grade,
      'school': school,
      'user_id': userId,
      'parent_id': parentId,
      'id': id,
    };
  }
}
