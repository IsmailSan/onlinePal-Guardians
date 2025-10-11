import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/reward_punishment/active_punishment_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/active_reward_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/confirm_punishment_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/confirm_reward_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/create_punishment_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/create_reward_mission_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/delete_punishment_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/delete_reward_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/punishment_history_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/reward_history_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/update_punishment_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/update_reward_mission_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/update_reward_status_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';

class RewardPunishmentRepository {
  Future<CreateRewardMissionResponse> createReward({
    int? missionId,
    String? condition,
    int? frequencyCount,
    int? pointsNeeded,
    required int childrenId,
    required String type,
    required String name,
    required String description,
    required String periodStartDate,
    required String periodEndDate,
  }) async {
    Dio dio = await HttpUtils().initDio();

    final formMap = {
      'children_id': childrenId,
      'type': type,
      'period_start_date': periodStartDate,
      'period_end_date': periodEndDate,
      'name': name,
      'description': description,
    };

    if (pointsNeeded != null) formMap['points_needed'] = pointsNeeded;
    if (missionId != null) formMap['mission_id'] = missionId;
    if (condition != null) formMap['condition'] = condition;
    if (frequencyCount != null) formMap['qty_condition'] = frequencyCount;

    var formData = FormData.fromMap(formMap);

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.post(ApiConfig.createReward, data: formData);
      final createRewardResponse =
          CreateRewardMissionResponse.fromJson(response.data);
      print("createRewardResponse : ${createRewardResponse.status}");
      return createRewardResponse;
    });
  }

  Future<UpdateRewardMissionResponse> updateReward({
    required int rewardId,
    int? missionId,
    String? condition,
    int? frequencyCount,
    int? pointsNeeded,
    required int childrenId,
    required String type,
    required String name,
    required String description,
    required String periodStartDate,
    required String periodEndDate,
  }) async {
    Dio dio = await HttpUtils().initDio();

    final formMap = {
      'children_id': childrenId,
      'type': type,
      'period_start_date': periodStartDate,
      'period_end_date': periodEndDate,
      'name': name,
      'description': description,
    };

    if (pointsNeeded != null) formMap['points_needed'] = pointsNeeded;
    if (missionId != null) formMap['mission_id'] = missionId;
    if (condition != null) formMap['condition'] = condition;
    if (frequencyCount != null && frequencyCount != 0) {
      formMap['qty_condition'] = frequencyCount;
    }

    var formData = FormData.fromMap(formMap);

    // 🔎 Print semua param sebelum request
    print("📤 Request updateReward:");
    formMap.forEach((key, value) {
      print("  $key : $value");
    });
    print("  URL  : ${ApiConfig.updateReward}/$rewardId");
    print("  Method: PUT");

    return await HttpUtils().safeApiCall(() async {
      try {
        Response response = await dio.put(
          "${ApiConfig.updateReward}/$rewardId",
          data: formMap,
        );

        final updateRewardMissionResponse =
            UpdateRewardMissionResponse.fromJson(response.data);

        print("✅ updateReward response: ${response.data}");
        return updateRewardMissionResponse;
      } on DioException catch (e) {
        print("❌ DioException occurred:");
        print("  Type    : ${e.type}");
        print("  Message : ${e.message}");
        print("  Response: ${e.response?.data}");
        print("  Status  : ${e.response?.statusCode}");
        rethrow;
      } catch (e) {
        print("❌ Unknown error: $e");
        rethrow;
      }
    });
  }

  Future<CreatePunishmentResponse> createPunishment({
    required int missionId,
    required int childrenId,
    required String name,
    String? description,
    String? pointReduction,
    required String periodStartDate,
    required String periodEndDate,
    required String condition,
    String? frequencyCount,
  }) async {
    Dio dio = await HttpUtils().initDio();

    Map<String, dynamic> data = {
      'mission_id': missionId,
      'children_id': childrenId,
      'period_start_date': periodStartDate,
      'period_end_date': periodEndDate,
      'condition': condition,
      'name': name,
      'description': description ?? '',
    };

    if (frequencyCount != null && frequencyCount.trim().isNotEmpty) {
      data['qty_condition'] = frequencyCount;
    }

    if (pointReduction != null && pointReduction.trim().isNotEmpty) {
      data['point_reduction'] = pointReduction;
    }

    var formData = FormData.fromMap(data);

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.post(ApiConfig.createPunishment, data: formData);
      final createPunishmentResponse =
          CreatePunishmentResponse.fromJson(response.data);
      print("createPunishmentResponse : $createPunishmentResponse");
      return createPunishmentResponse;
    });
  }

  Future<UpdatePunishmentResponse> updatePunishment({
    required int punishmentId,
    required int missionId,
    required int childrenId,
    required String name,
    String? description,
    String? pointReduction,
    required String periodStartDate,
    required String periodEndDate,
    required String condition,
    String? frequencyCount,
  }) async {
    Dio dio = await HttpUtils().initDio();

    Map<String, dynamic> data = {
      'mission_id': missionId,
      'children_id': childrenId,
      'period_start_date': periodStartDate,
      'period_end_date': periodEndDate,
      'condition': condition,
      'name': name,
      'description': description ?? '',
    };

    if (frequencyCount != null &&
        frequencyCount.trim().isNotEmpty &&
        frequencyCount.trim() != "0") {
      data['qty_condition'] = frequencyCount;
    }

    if (pointReduction != null && pointReduction.trim().isNotEmpty) {
      data['point_reduction'] = pointReduction;
    }

    // 🔍 debug log: pastikan value benar
    print("📤 Request updatePunishment:");
    data.forEach((key, value) {
      print("  $key : $value");
    });
    print("  URL  : ${ApiConfig.updatePunishment}/$punishmentId");
    print("  Method: PUT");

    return await HttpUtils().safeApiCall(() async {
      try {
        Response response = await dio.put(
          "${ApiConfig.updatePunishment}/$punishmentId",
          data: data,
        );

        final updatePunishmentResponse =
            UpdatePunishmentResponse.fromJson(response.data);

        print("✅ updatePunishmentResponse : ${response.data}");
        return updatePunishmentResponse;
      } on DioException catch (e) {
        // detail error log
        print("❌ DioException occurred:");
        print("  Type    : ${e.type}");
        print("  Message : ${e.message}");
        print("  Response: ${e.response?.data}");
        print("  Status  : ${e.response?.statusCode}");
        rethrow; // biar tetap dilempar ke safeApiCall
      } catch (e) {
        print("❌ Unknown error: $e");
        rethrow;
      }
    });
  }

  Future<ActiveRewardListResponse> getActiveRewardList({
    required int childrenId,
    required int cursor,
    required int limit,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio.get(
        "${ApiConfig.rewardList}?children_id=${childrenId}&cursor=$cursor&limit=$limit&status[]=active",
      );
      final activeRewardListResponse =
          ActiveRewardListResponse.fromJson(response.data);
      print("activeRewardListResponse : ${response}");
      return activeRewardListResponse;
    });
  }

  Future<RewardHistoryListResponse> getHistoryRewardList({
    required int childrenId,
    required int cursor,
    required int limit,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio.get(
        "${ApiConfig.rewardList}?children_id=${childrenId}&cursor=$cursor&limit=$limit&status[]=completed&status[]=not_completed",
      );
      final rewardHistoryListResponse =
          RewardHistoryListResponse.fromJson(response.data);
      print("RewardHistoryListResponse : ${response}");
      return rewardHistoryListResponse;
    });
  }

  Future<ActivePunishmentListResponse> getActivePunishmentList({
    required int childrenId,
    required int cursor,
    required int limit,
  }) async {
    Dio dio = await HttpUtils().initDio();

    final url =
        "${ApiConfig.punishmentList}?children_id=$childrenId&cursor=$cursor&limit=$limit&status[]=active";

    print("📤 Request getActivePunishmentList:");
    print("  children_id : $childrenId");
    print("  cursor      : $cursor");
    print("  limit       : $limit");
    print("  URL         : $url");
    print("  Method      : GET");

    try {
      return await HttpUtils().safeApiCall(() async {
        Response response = await dio.get(url);

        print("✅ Response [${response.statusCode}] from $url");
        print("Body: ${response.data}");

        final activePunishmentListResponse =
            ActivePunishmentListResponse.fromJson(response.data);
        return activePunishmentListResponse;
      });
    } on DioException catch (e) {
      // Tangkap error spesifik dari Dio
      print("❌ DioException on getActivePunishmentList:");
      print("  URL     : $url");
      print("  Message : ${e.message}");
      print("  Type    : ${e.type}");
      if (e.response != null) {
        print("  Status  : ${e.response?.statusCode}");
        print("  Data    : ${e.response?.data}");
      }
      rethrow; // lempar lagi biar bisa ditangani di Bloc/Repository
    } catch (e, stackTrace) {
      // Tangkap error lain
      print("❌ Unknown error in getActivePunishmentList: $e");
      print(stackTrace);
      rethrow;
    }
  }

  Future<PunishmentHistoryListResponse> getHistoryPunishmentList({
    required int childrenId,
    required int cursor,
    required int limit,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio.get(
        "${ApiConfig.punishmentList}?children_id=${childrenId}&cursor=$cursor&limit=$limit&status[]=completed&status[]=not_completed",
      );
      final punishmentHistoryListResponse =
          PunishmentHistoryListResponse.fromJson(response.data);
      print("PunishmentHistoryListResponse : ${response}");
      return punishmentHistoryListResponse;
    });
  }

  Future<DeleteRewardResponse> deleteReward({
    required int rewardId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.delete(ApiConfig.deleteReward + "/${rewardId}");

      final deleteRewardResponse = DeleteRewardResponse.fromJson(response.data);
      print("status : ${deleteRewardResponse.status}");
      return deleteRewardResponse;
    });
  }

  Future<DeletePunishmentResponse> deletePunishment({
    required int punishmentId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.delete(ApiConfig.deletePunishment + "/${punishmentId}");

      final deletePunishmentResponse =
          DeletePunishmentResponse.fromJson(response.data);
      print("status : ${deletePunishmentResponse.status}");
      return deletePunishmentResponse;
    });
  }

  Future<ConfirmRewardResponse> confirmReward({
    required int rewardId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.patch(ApiConfig.reward + "/${rewardId}/confirm");

      final confirmRewardResponse =
          ConfirmRewardResponse.fromJson(response.data);
      print("status : ${confirmRewardResponse.status}");
      return confirmRewardResponse;
    });
  }

  Future<UpdateRewardStatusResponse> updateRewardStatus({
    required int rewardId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.patch(ApiConfig.reward + "/${rewardId}/daily-status");

      final updateRewardStatusResponse =
          UpdateRewardStatusResponse.fromJson(response.data);
      print("status : ${updateRewardStatusResponse.status}");
      return updateRewardStatusResponse;
    });
  }

  Future<ConfirmPunishmentResponse> confirmPunishment({
    required int punishmentId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.patch(ApiConfig.punishment + "/${punishmentId}/confirm");

      final confirmPunishmentResponse =
          ConfirmPunishmentResponse.fromJson(response.data);
      print("status : ${confirmPunishmentResponse.status}");
      return confirmPunishmentResponse;
    });
  }

  Future<UpdateRewardStatusResponse> updatePunishmentStatus({
    required int rewardId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response =
          await dio.patch(ApiConfig.punishment + "/${rewardId}/daily-status");

      final updateRewardStatusResponse =
          UpdateRewardStatusResponse.fromJson(response.data);
      print("status : ${updateRewardStatusResponse.status}");
      return updateRewardStatusResponse;
    });
  }
}
