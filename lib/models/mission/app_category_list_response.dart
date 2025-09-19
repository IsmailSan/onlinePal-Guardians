class AppCategoryListResponse {
  final String? status;
  final String? message;
  final List<AppCategoryData>? data;

  AppCategoryListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AppCategoryListResponse.fromJson(Map<String, dynamic> json) {
    return AppCategoryListResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? List<AppCategoryData>.from(
              json['data'].map((x) => AppCategoryData.fromJson(x)),
            )
          : null,
    );
  }
}

class AppCategoryData {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  AppCategoryData({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory AppCategoryData.fromJson(Map<String, dynamic> json) {
    return AppCategoryData(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
