class ScreenTimeResponse {
  final String? status;
  final String? message;
  final ScreenTimeData? data;

  ScreenTimeResponse({
    this.status,
    this.message,
    this.data,
  });

  factory ScreenTimeResponse.fromJson(Map<String, dynamic> json) {
    return ScreenTimeResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? ScreenTimeData.fromJson(json['data']) : null,
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

class ScreenTimeData {
  final String? childId;
  final List<ScreenTimeItem>? data;

  ScreenTimeData({
    this.childId,
    this.data,
  });

  factory ScreenTimeData.fromJson(Map<String, dynamic> json) {
    return ScreenTimeData(
      childId: json['child_id'],
      data: json['data'] != null
          ? List<ScreenTimeItem>.from(
              json['data'].map((x) => ScreenTimeItem.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'child_id': childId,
      'data': data?.map((x) => x.toJson()).toList(),
    };
  }
}

class ScreenTimeItem {
  final String? date;
  final String? totalScreenTime;

  ScreenTimeItem({
    this.date,
    this.totalScreenTime,
  });

  factory ScreenTimeItem.fromJson(Map<String, dynamic> json) {
    return ScreenTimeItem(
      date: json['date'],
      totalScreenTime: json['total_screen_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'total_screen_time': totalScreenTime,
    };
  }
}
