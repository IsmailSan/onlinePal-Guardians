class AppListResponse {
  final String? status;
  final String? message;
  final List<AppData>? data;

  AppListResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AppListResponse.fromJson(Map<String, dynamic> json) {
    return AppListResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? List<AppData>.from(json['data'].map((x) => AppData.fromJson(x)))
          : [],
    );
  }
}

class AppData {
  final int? id;
  final int? categoryAppsId;
  final String? name;
  final String? createdAt;
  final String? updatedAt;
  final CategoryApps? categoryApps;

  AppData({
    this.id,
    this.categoryAppsId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.categoryApps,
  });

  factory AppData.fromJson(Map<String, dynamic> json) {
    return AppData(
      id: json['id'],
      categoryAppsId: json['category_apps_id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      categoryApps: json['category_apps'] != null
          ? CategoryApps.fromJson(json['category_apps'])
          : null,
    );
  }
}

class CategoryApps {
  final int? id;
  final String? name;
  final String? createdAt;
  final String? updatedAt;

  CategoryApps({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory CategoryApps.fromJson(Map<String, dynamic> json) {
    return CategoryApps(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
