import 'dart:convert';

class RegistrationResponse {
  final String status;
  final String message;
  final String token;
  final String username;
  final String role;
  final int id;

  RegistrationResponse({
    required this.status,
    required this.message,
    required this.token,
    required this.username,
    required this.role,
    required this.id,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      status: json['status'],
      message: json['message'],
      token: json['data']['token'],
      username: json['data']['user']['username'],
      role: json['data']['user']['role'],
      id: json['data']['user']['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': {
        'token': token,
        'user': {
          'username': username,
          'role': role,
          'id': id,
        },
      },
    };
  }

  static RegistrationResponse fromRawJson(String str) =>
      RegistrationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}
