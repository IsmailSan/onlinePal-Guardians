
class UpdateProfileResponse {
  final String status;
  final String message;
  final ParentProfile data;

  UpdateProfileResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: ParentProfile.fromJson(json['data'] ?? {}),
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
  });

  factory ParentProfile.fromJson(Map<String, dynamic> json) {
    return ParentProfile(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      name: json['name'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      gender: json['gender'] ?? '',
      nationality: json['nationality'] ?? '',
      province: json['province'] ?? '',
      city: json['city'] ?? '',
      postalCode: json['postal_code'] ?? '',
      occupation: json['occupation'] ?? '',
      rangeOfFamilyIncome: json['range_of_family_income'] ?? '',
      numberOfChildren: json['number_of_children'] is int
          ? json['number_of_children']
          : int.tryParse(json['number_of_children'].toString()) ?? 0,
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
    };
  }
}
