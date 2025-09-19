import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/schedule/suggested_schedules_response.dart';
import 'package:online_pal_guardians/models/schedule/create_schedule_response.dart';
import 'package:online_pal_guardians/models/schedule/schedule_list_response.dart';
import 'package:online_pal_guardians/models/schedule/update_schedule_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';

class ScheduleRepository {

  Future<CreateScheduleResponse> createSchedule({
    required String date,
    String? dateEnd,
    required String timeStart,
    required String timeEnd,
    int? scheduleItemId,
    String? customName,
    String? customCategory,
    String? customIcon,
    String? customColor,
    required String repeat,
    required int childrenId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    final Map<String, dynamic> body = {
      "date": date,
      "date_end": dateEnd,
      "time_start": timeStart,
      "time_end": timeEnd,
      "schedule_item_id": scheduleItemId,
      "custom_name": customName,
      "custom_category": customCategory,
      "custom_icon": customIcon,
      "custom_color": customColor,
      "repeat": repeat,
      "children_id": childrenId
    };

    final formData = FormData.fromMap(body);

    return await HttpUtils().safeApiCall(() async {
      final response = await dio.post(ApiConfig.createSchedule, data: formData);
      final createScheduleResponse = CreateScheduleResponse.fromJson(response.data);
      print("status create schedule: ${createScheduleResponse.status}");
      return createScheduleResponse;
    });
  }


  Future<UpdateScheduleResponse> updateSchedule({
    required int scheduleId,
    required String date,
    required String timeStart,
    required String timeEnd,
    int? scheduleItemId,
    String? customName,
    String? customCategory,
    String? customIcon,
    String? customColor,
  }) async {
    Dio dio = await HttpUtils().initDio();

    final Map<String, dynamic> body = {
      "date": date,
      "time_start": timeStart,
      "time_end": timeEnd,
      "schedule_item_id": scheduleItemId,
      "custom_name": customName,
      "custom_category": customCategory,
      "custom_icon": customIcon,
      "custom_color": customColor,
    };

    final formData = FormData.fromMap(body);

    return await HttpUtils().safeApiCall(() async {
      Response response =
      await dio.post(ApiConfig.updateSchedule + "/${scheduleId}", data: formData);
      final updateMissionResponse =
      UpdateScheduleResponse.fromJson(response.data);
      print("status update schedule: ${updateMissionResponse.status}");
      return updateMissionResponse;
    });
  }

  Future<ScheduleListResponse> getScheduleList({
    required int childrenId,
    required String dateStart,
    required String dateEnd,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio.get(
        "${ApiConfig.scheduleList}?children_id=$childrenId&date_start=$dateStart&date_end=${dateEnd}",
      );
      final scheduleListResponse = ScheduleListResponse.fromJson(response.data);
      print("schedule list : ${response}");
      return scheduleListResponse;
    });
  }

  Future<SuggestedSchedulesResponse> getSuggestedSchedules({
    required String search,
    required int cursor,
    required int limit,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio.get(
        "${ApiConfig.suggestedSchedules}?search=${search}&cursor=$cursor&limit=$limit",
      );
      final suggestedSchedulesResponse = SuggestedSchedulesResponse.fromJson(response.data);
      print("suggested schedules response : ${response}");
      return suggestedSchedulesResponse;
    });
  }
}
