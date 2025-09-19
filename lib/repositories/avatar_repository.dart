import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/avatar/avatar_list_response.dart';
import 'package:online_pal_guardians/models/avatar/update_avatar_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/app_exeption.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';


class AvatarRepository {
  Future<UpdateAvatarResponse> updateAvatar({required int avatarId}) async {
    late UpdateAvatarResponse avatarResponse;
    Dio dio = await HttpUtils().initDio();

    final data = {"avatar_id": avatarId};

    try {
      final response = await dio.post(
        ApiConfig.updateAvatar,
        data: data,
      );
      avatarResponse = UpdateAvatarResponse.fromJson(response.data);
    } catch (e) {
      throw AppException("Gagal menmperbarui data avatar. Silakan coba lagi.");
    }
    return avatarResponse;
  }

  Future<AvatarListResponse> avatarList({required String gender}) async {
    late AvatarListResponse avatarListResponse;
    Dio dio = await HttpUtils().initDio();
    try {
      final response = await dio.get(
        "${ApiConfig.avatarList}?gender=${gender}&role=parent"
      );
      avatarListResponse = AvatarListResponse.fromJson(response.data);
      print("avatar respone ${avatarListResponse}");
    } catch (e) {
      throw AppException("Gagal mengambil data avatar. Silakan coba lagi.");
    }
    return avatarListResponse;
  }
}
