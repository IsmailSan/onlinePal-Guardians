class ScreenActivityResponse {
  final String? status;
  final String? message;
  final ScreenActivityData? data;

  ScreenActivityResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ScreenActivityResponse.fromJson(Map<String, dynamic> json) {
    return ScreenActivityResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? ScreenActivityData.fromJson(json['data'])
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

class ScreenActivityData {
  final String? childId;
  final List<ScreenActivityItem>? screenActivity;

  ScreenActivityData({
    this.childId,
    this.screenActivity,
  });

  factory ScreenActivityData.fromJson(Map<String, dynamic> json) {
    return ScreenActivityData(
      childId: json['child_id'],
      screenActivity: json['screen_activity'] != null
          ? List<ScreenActivityItem>.from(json['screen_activity']
              .map((x) => ScreenActivityItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_id': childId,
      'screen_activity': screenActivity?.map((x) => x.toJson()).toList(),
    };
  }
}

class ScreenActivityItem {
  final String? nameApps;
  final int? averageToday;
  final int? averageLast7Days;
  final int? averageLast30Days;

  ScreenActivityItem({
    this.nameApps,
    this.averageToday,
    this.averageLast7Days,
    this.averageLast30Days,
  });

  factory ScreenActivityItem.fromJson(Map<String, dynamic> json) {
    return ScreenActivityItem(
      nameApps: json['name_apps'],
      averageToday: json['average_today'],
      averageLast7Days: json['average_last_7_days'],
      averageLast30Days: json['average_last_30_days'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name_apps': nameApps,
      'average_today': averageToday,
      'average_last_7_days': averageLast7Days,
      'average_last_30_days': averageLast30Days,
    };
  }
}
