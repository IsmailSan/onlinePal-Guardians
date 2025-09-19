import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/monitoring/screen_activity_response.dart';
import 'package:online_pal_guardians/models/monitoring/screen_time_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';

class MonitoringRepository {
  Future<ScreenTimeResponse> getScreenTime(String childrenId) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.get("${ApiConfig.getScreenTime}?children_id=$childrenId");
      final screenTimeResponse = ScreenTimeResponse.fromJson(response.data);
      print("status screen time : ${screenTimeResponse.status}");
      return screenTimeResponse;
    });
  }

  Future<ScreenActivityResponse> getScreenActivity(String childrenId) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio
          .get("${ApiConfig.getScreenActivity}?children_id=$childrenId");
      final screenActivityResponse =
          ScreenActivityResponse.fromJson(response.data);
      print("status screen acti : ${screenActivityResponse.status}");
      return screenActivityResponse;
    });
  }
}
