import 'package:dio/dio.dart';
import 'package:online_pal_guardians/utils/string_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HttpUtils {
  static final HttpUtils _instance = HttpUtils._internal();
  factory HttpUtils() => _instance;
  HttpUtils._internal();

  SharedPreferences? _preferences;
  final Dio _dio = Dio();

  Future<Dio> initDio() async {
    _preferences ??= await SharedPreferences.getInstance();
    _dio.options.headers["Accept"] = "application/json";

    final token = _preferences?.getString(StringValue.access_token);
    if (token != null) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }
    _dio.interceptors.clear();

    return _dio;
  }

  Future<T> safeApiCall<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final responseData = e.response?.data;

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        throw "Koneksi timeout. Silakan coba lagi.";
      }

      String errorMessage = "Silakan coba lagi.";
      if (responseData is Map && responseData.containsKey('message')) {
        errorMessage = responseData['message'] ?? errorMessage;
      }

      switch (statusCode) {
        case 400:
          throw errorMessage;
        case 401:
          throw "Tidak diizinkan. Silakan login ulang.";
        case 403:
          throw "Akses ditolak.";
        case 404:
          throw "Data tidak ditemukan.";
        case 422:
          throw errorMessage;
        case 500:
          throw "Terjadi kesalahan pada server. Silakan coba lagi.";
        default:
        // final message = e.response?.data['message'] ?? 'Terjadi kesalahan. Silakan coba lagi.';
          throw errorMessage;
      }
    } catch (e) {
      throw "Silakan coba lagi.";
    }
  }
}
