class CreateChildProfileResponse {
  final String status;
  final String message;
  final ChildProfile data;

  CreateChildProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory CreateChildProfileResponse.fromJson(Map<String, dynamic> json) {
    return CreateChildProfileResponse(
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
  final String name;
  final String dateOfBirth;
  final String gender;
  final String liveWithParents;
  final String grade;
  final String school;
  final int userId;
  final int parentId;
  final int id;

  ChildProfile({
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.liveWithParents,
    required this.grade,
    required this.school,
    required this.userId,
    required this.parentId,
    required this.id,
  });

  factory ChildProfile.fromJson(Map<String, dynamic> json) {
    return ChildProfile(
      name: json['name'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
      liveWithParents: json['live_with_parents'],
      grade: json['grade'],
      school: json['school'],
      userId: json['user_id'],
      parentId: json['parent_id'],
      id: json['id'],
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
