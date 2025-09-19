import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/notification/mark_as_notif_response.dart';
import 'package:online_pal_guardians/models/notification/notification_list_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';


class NotificationRepository {
  Future<MarkAsReadNotifResponse> markAsReadNotif({
    required int notificationId,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response =
      await dio.post(ApiConfig.markAsReadNotification + "/${notificationId}");
      final markAsReadNotifResponse =
      MarkAsReadNotifResponse.fromJson(response.data);
      return markAsReadNotifResponse;
    });
  }

  Future<NotificationListResponse> getNotificationList({
    required String search,
    required int cursor,
    required int limit,
  }) async {
    Dio dio = await HttpUtils().initDio();

    return await HttpUtils().safeApiCall(() async {
      Response response = await dio.get(
        "${ApiConfig.notificationList}?search=${search}&cursor=$cursor&limit=$limit",
      );
      final notificationListResponse = NotificationListResponse.fromJson(response.data);
      print("notification response : ${response}");
      return notificationListResponse;
    });
  }
}