import 'dart:convert';

class LogoutResponse {
  final String status;
  final String message;
  final LogoutData data;

  LogoutResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      status: json['status'],
      message: json['message'],
      data: LogoutData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };

  static LogoutResponse fromRawJson(String str) =>
      LogoutResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class LogoutData {
  LogoutData();

  factory LogoutData.fromJson(dynamic json) {
    return LogoutData();
  }

  Map<String, dynamic> toJson() => {};
}
