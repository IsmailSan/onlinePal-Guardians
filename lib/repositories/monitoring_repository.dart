import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/monitoring/screen_activity_response.dart';
import 'package:online_pal_guardians/models/monitoring/screen_time_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';

class MonitoringRepository {
  Future<ScreenTimeResponse> getScreenTime(String childrenId) async {
    print("user id nya $childrenId");
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      try {
        // pastikan integer
        final id = int.tryParse(childrenId);
        if (id == null) {
          throw Exception(
              "childrenId harus berupa angka, tapi dapat: $childrenId");
        }

        Response response = await dio.get(
          "${ApiConfig.getScreenTime}?children_id=$id",
        );

        print("raw response screen time: ${response.data}");

        final screenTimeResponse = ScreenTimeResponse.fromJson(response.data);
        print("status screen time : ${screenTimeResponse.status}");
        return screenTimeResponse;
      } on DioException catch (e) {
        print("Dio error getScreenTime: ${e.message}");
        if (e.response != null) {
          print("Dio error response: ${e.response?.data}");
          print("Dio error status code: ${e.response?.statusCode}");
        }
        rethrow;
      } catch (e, stack) {
        print("Unexpected error getScreenTime: $e");
        print(stack);
        rethrow;
      }
    });
  }

  Future<ScreenActivityResponse> getScreenActivity(String childrenId) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      try {
        // pastikan integer
        final id = int.tryParse(childrenId);
        if (id == null) {
          throw Exception(
              "childrenId harus berupa angka, tapi dapat: $childrenId");
        }

        Response response = await dio.get(
          "${ApiConfig.getScreenActivity}?children_id=$id",
        );

        print("raw response screen activity: ${response.data}");

        final screenActivityResponse =
            ScreenActivityResponse.fromJson(response.data);
        print("status screen acti : ${screenActivityResponse.status}");
        return screenActivityResponse;
      } on DioException catch (e) {
        print("Dio error getScreenActivity: ${e.message}");
        if (e.response != null) {
          print("Dio error response: ${e.response?.data}");
          print("Dio error status code: ${e.response?.statusCode}");
        }
        rethrow;
      } catch (e, stack) {
        print("Unexpected error getScreenActivity: $e");
        print(stack);
        rethrow;
      }
    });
  }
}
