import 'dart:convert';

class DeleteRewardResponse {
  final String status;
  final String message;
  final dynamic data; // atau bisa juga: final DeleteReward? data;

  DeleteRewardResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory DeleteRewardResponse.fromJson(Map<String, dynamic> json) {
    return DeleteRewardResponse(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: null, // paksa null, abaikan json['data']
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': null, // tetap null saat toJson juga
  };

  static DeleteRewardResponse fromRawJson(String str) =>
      DeleteRewardResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}
