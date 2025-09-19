import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/mission/app_list_response.dart';
import 'package:online_pal_guardians/models/mission/app_category_list_response.dart';
import 'package:online_pal_guardians/models/mission/create_mission_from_suggestion_response.dart';
import 'package:online_pal_guardians/models/mission/create_new_mission_response.dart';
import 'package:online_pal_guardians/models/mission/delete_mission_response.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/models/mission/suggested_mission_list_response.dart';
import 'package:online_pal_guardians/models/mission/update_mission_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';

class MissionRepository {
  Future<SuggestedMissionListResponse> getSuggestedMissionList({
    required int cursor,
    required int limit,
  }) async {
    Dio dio = await HttpUtils().initDio();

    print("📡 Calling API cursor=$cursor, limit=$limit");

    try {
      final response = await dio.get(
        "${ApiConfig.suggestedMissionList}?cursor=$cursor&limit=$limit",
      );

      print("📥 Raw JSON: ${response.data}");

      final suggestedMissionResponse =
          SuggestedMissionListResponse.fromJson(response.data);

      print("✅ Parsed ${suggestedMissionResponse.data.data.length} missions");

      return suggestedMissionResponse;
    } catch (e, stack) {
      print("❌ Error saat call atau parsing API: $e");
      print("📛 Stacktrace: $stack");
      rethrow;
    }
  }

  Future<CreateMissionFromSuggestionResponse> createMissionFromSuggestion({
    required int missionSuggestionId,
    required int childrenId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    var formData = FormData.fromMap({
      'mission_suggestion_id': missionSuggestionId,
      'children_id': childrenId,
    });

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.post(ApiConfig.createMissionFromSuggestion, data: formData);
      final createMissionFromSuggestionResponse =
          CreateMissionFromSuggestionResponse.fromJson(response.data);
      print("status : ${createMissionFromSuggestionResponse.status}");
      return createMissionFromSuggestionResponse;
    });
  }

  Future<CreateNewMissionResponse> createNewMission({
    required int childrenId,
    required String name,
    required String description,
    required int reward,
    required int punishment,
    required String periodeTime,
    required String startDate,
    required String endDate,
    required String type,
    required String condition,
    required int categoryAppsId,
    required int appsId,
    String? directReward,
    String? directPunishment,
    int? pointAddition,
    int? pointDeduction,
  }) async {
    Dio dio = await HttpUtils().initDio();

    final formData = FormData.fromMap({
      'children_id': childrenId,
      'name': name,
      'description': description,
      'reward': reward,
      'punishment': punishment,
      'periode_time': periodeTime,
      'start_date': startDate,
      'end_date': endDate,
      'type': type,
      'condition': condition,
      'category_apps_id': categoryAppsId,
      'apps_id': appsId,
      if (directReward != null) 'direct_reward': directReward,
      if (directPunishment != null) 'direct_punishment': directPunishment,
      if (pointAddition != null) 'point_addition': pointAddition,
      if (pointDeduction != null) 'point_deduction': pointDeduction,
    });

    print("🚀 Params dikirim ke backend:");
    formData.fields.forEach((field) {
      print("  ${field.key} : ${field.value}");
    });

    return await HttpUtils().safeApiCall(() async {
      try {
        Response response =
            await dio.post(ApiConfig.createNewMission, data: formData);

        final createNewMissionResponse =
            CreateNewMissionResponse.fromJson(response.data);

        print("status : ${createNewMissionResponse.status}");
        return createNewMissionResponse;
      } on DioError catch (e) {
        // log status code dari backend
        if (e.response != null) {
          print("❌ DioError Response: ${e.response?.data}");
          print("❌ Status code: ${e.response?.statusCode}");
          print("❌ Headers: ${e.response?.headers}");
        } else {
          print("❌ DioError Message: ${e.message}");
        }
        rethrow;
      }
    });
  }

  Future<CreateMissionFromSuggestionResponse> createAllMissionFromSuggestion({
    required int childrenId,
    required String type,
  }) async {
    Dio dio = await HttpUtils().initDio();

    final formData = FormData.fromMap({
      'children_id': childrenId,
      'type': type,
    });

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.post(ApiConfig.createAllMissionFromMission, data: formData);
      final createMissionFromSuggestionResponse =
          CreateMissionFromSuggestionResponse.fromJson(response.data);
      print("status : ${createMissionFromSuggestionResponse.status}");
      return createMissionFromSuggestionResponse;
    });
  }

  Future<DeleteMissionResponse> deleteMission({
    required int missionId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.delete(ApiConfig.deleteMission + "?mission_id=$missionId");

      final deleteMissionResponse =
          DeleteMissionResponse.fromMap(response.data);
      print("status : ${deleteMissionResponse.status}");
      return deleteMissionResponse;
    });
  }

  Future<UpdateMissionResponse> updateMission({
    required int missionId,
    required int childrenId,
    required String name,
    required String description,
    required int reward,
    required int punishment,
    required String periodeTime,
    required String startDate,
    required String endDate,
    required String type,
    required String condition,
    required String appCategory,
    required String appName,
    String? directReward,
    String? directPunishment,
    int? pointAddition,
    int? pointDeduction,
  }) async {
    Dio dio = await HttpUtils().initDio();

    final formData = FormData.fromMap({
      'children_id': childrenId,
      'name': name,
      'description': description,
      'reward': reward,
      'punishment': punishment,
      'periode_time': periodeTime,
      'start_date': startDate,
      'end_date': endDate,
      'type': type,
      'condition': condition,
      'app_category': appCategory,
      'app_name': appName,
      if (directReward != null) 'direct_reward': directReward,
      if (directPunishment != null) 'direct_punishment': directPunishment,
      if (pointAddition != null) 'point_addition': pointAddition,
      if (pointDeduction != null) 'point_deduction': pointDeduction,
    });

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio
          .post(ApiConfig.updateMission + "/${missionId}", data: formData);
      final updateMissionResponse =
          UpdateMissionResponse.fromJson(response.data);
      return updateMissionResponse;
    });
  }

  Future<MissionListResponse> getMissionList({
    required int childrenId,
    required String status,
    required int cursor,
    required int limit,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio.get(
        "${ApiConfig.missionList}?children_id=$childrenId&cursor=$cursor&limit=$limit&status[]=$status",
      );

      // 🔹 print status & raw data
      print("➡️ REQUEST URL: ${response.requestOptions.uri}");
      print("➡️ STATUS CODE: ${response.statusCode}");
      print("➡️ RESPONSE DATA: ${response.data}");

      try {
        final missionListResponse = MissionListResponse.fromJson(response.data);

        return missionListResponse;
      } catch (e, stacktrace) {
        print("❌ ERROR PARSING RESPONSE: $e");
        print("STACKTRACE: $stacktrace");
        rethrow; // biar kelihatan errornya di console
      }
    });
  }

  Future<MissionListResponse> getMissionHistoryList({
    required int childrenId,
    required int cursor,
    required int limit,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio.get(
        "${ApiConfig.missionList}?children_id=$childrenId&cursor=$cursor&limit=$limit&status[]=reject&status[]=completed&status[]=not_completed&status[]=canceled",
      );
      final missionListResponse = MissionListResponse.fromJson(response.data);
      print("status : ${response}");
      return missionListResponse;
    });
  }

  Future<AppCategoryListResponse> getAppCategoryList({
    required int cursor,
    required int limit,
  }) async {
    Dio dio = await HttpUtils().initDio();

    try {
      final response = await dio.get(
        "${ApiConfig.appCategoryList}?cursor=$cursor&limit=$limit",
      );

      print("📥 Raw JSON: ${response.data}");

      final appCategoryListResponse =
          AppCategoryListResponse.fromJson(response.data);

      print("✅ Parsed ${appCategoryListResponse.data} app category list");

      return appCategoryListResponse;
    } catch (e, stack) {
      print("❌ Error saat call atau parsing API: $e");
      print("📛 Stacktrace: $stack");
      rethrow;
    }
  }

  Future<AppListResponse> getAppList({
    required int cursor,
    required int limit,
    required int categoryAppId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    try {
      final response = await dio.get(
        "${ApiConfig.appList}?cursor=$cursor&limit=$limit&category_apps_id=$categoryAppId",
      );

      print("📥 Raw JSON: ${response.data}");

      final appListResponse = AppListResponse.fromJson(response.data);

      print("✅ Parsed ${appListResponse.data} app list");

      return appListResponse;
    } catch (e, stack) {
      print("❌ Error saat call atau parsing API: $e");
      print("📛 Stacktrace: $stack");
      rethrow;
    }
  }
}
