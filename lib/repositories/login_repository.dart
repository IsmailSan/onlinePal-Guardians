import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/login/login_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';

class LoginRepository {
  Future<LoginResponse> login(String username, String password, String role) async {
    late LoginResponse loginResponse;
    try {
      Dio dio = await HttpUtils().initDio();

      var formData = FormData.fromMap({
        'username': username,
        'password': password,
        'role': role,
      });

      Response response = await dio.post(ApiConfig.login, data: formData);
      loginResponse = LoginResponse.fromJson(response.data);
      print("token : ${loginResponse.data.token}");
    } catch (e) {
      if (e is DioException) {
        print("DioException occurred: ${e.message}");
        print("Status code: ${e.response?.statusCode}");
        print("Response data: ${e.response?.data}");
        if (e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          print("timeout");
        } else if (e.response?.statusCode == 401) {
          final message = e.response?.data["message"] ?? "Login gagal";
          throw message;
        } else if (e.response != null) {
          final message ='Silakan Coba Lagi';
          throw message;
        } else {
          // throw Exception("NETWORK_DIO_ERROR");
          final message ='Silakan Coba Lagi';
          throw message;
        }
      } else {
        final message ='Silakan Coba Lagi';
        throw message;
      }
    }
    return loginResponse;
  }
}
