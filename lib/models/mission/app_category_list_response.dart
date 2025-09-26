class AppCategoryListResponse {
  final String? status;
  final String? message;
  final AppCategoryListData? data;

  AppCategoryListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AppCategoryListResponse.fromJson(Map<String, dynamic> json) {
    return AppCategoryListResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? AppCategoryListData.fromJson(json['data'])
          : null,
    );
  }
}

class AppCategoryListData {
  final List<AppCategoryData>? data;
  final String? nextCursor;

  AppCategoryListData({
    this.data,
    this.nextCursor,
  });

  factory AppCategoryListData.fromJson(Map<String, dynamic> json) {
    return AppCategoryListData(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((x) => AppCategoryData.fromJson(x))
              .toList()
          : [],
      nextCursor: json['next_cursor'] as String?,
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
      id: json['id'] is int ? json['id'] as int : int.tryParse("${json['id']}"),
      name: json['name'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );
  }
}
