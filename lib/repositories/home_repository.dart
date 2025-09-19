import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/home/home_response.dart';
import 'package:online_pal_guardians/models/logout/logout_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';

class HomeRepository {
  Future<LogoutResponse> logout() async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio.post(ApiConfig.logout);
      final logoutResponse = LogoutResponse.fromJson(response.data);
      print("status logout : ${logoutResponse.status}");
      return logoutResponse;
    });
  }

  Future<HomeResponse> getHome() async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio.get(ApiConfig.home);
      final homeResponse = HomeResponse.fromJson(response.data);
      print("status home : ${homeResponse.status}");
      return homeResponse;
    });
  }
}
