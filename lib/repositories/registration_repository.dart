import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/registration/registration_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';

class RegistrationRepository {
  Future<RegistrationResponse> register(String username, String password, String passwordConfirmation) async {
    late RegistrationResponse registrationResponse;
    try {
      Dio dio = await HttpUtils().initDio();

      var formData = FormData.fromMap({
        'username': username,
        'password': password,
        'password_confirmation': passwordConfirmation,
      });

      Response response = await dio.post(ApiConfig.register, data: formData);
      registrationResponse = RegistrationResponse.fromJson(response.data);
      print("message : ${registrationResponse.message}");
    } catch (e) {
      if (e is DioException) {
        print("DioException occurred: ${e.message}");
        print("Status code: ${e.response?.statusCode}");
        print("Response data: ${e.response?.data}");
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          print("timeout");
        } else if (e.response?.statusCode == 401) {
          throw Exception(e.response?.data["message"]);
        } else if (e.response != null) {
          final message = e.response?.data['message'] ?? 'Silakan Coba Lagi';
          print("API Error message: $message");
          throw message;
        } else {
          final message = e.response?.data['message'] ?? 'Silakan Coba Lagi';
          print("API Error message: $message");
          throw message;
        }
      } else {
        final message = 'Silakan Coba Lagi';
        print("API Error message: $message");
        throw message;
      }
    }
    return registrationResponse;
  }
}