import 'package:dio/dio.dart';
import 'package:online_pal_guardians/models/avatar/avatar_list_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/child_preference_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/create_child_profile_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_child_profile_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/update_child_avatar_response.dart';
import 'package:online_pal_guardians/models/profile/child_profile/update_child_profile_response.dart';
import 'package:online_pal_guardians/models/profile/get_profile_response.dart';
import 'package:online_pal_guardians/models/profile/update_profile_response.dart';
import 'package:online_pal_guardians/network/api_config.dart';
import 'package:online_pal_guardians/utils/http_utils.dart';

class ProfileRepository {
  final HttpUtils _httpUtils = HttpUtils();

  Future<UpdateProfileResponse> updateProfile({
    required String name,
    required String dateOfBirth,
    required String gender,
    required String nationality,
    required String province,
    required String city,
    required String postalCode,
    required String occupation,
    required String rangeOfFamilyIncome,
    required int numberOfChildren,
  }) async {
    final dio = await _httpUtils.initDio();

    final formData = FormData.fromMap({
      "name": name,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "nationality": nationality,
      "province": province,
      "city": city,
      "postal_code": postalCode,
      "occupation": occupation,
      "range_of_family_income": rangeOfFamilyIncome,
      "number_of_children": numberOfChildren,
    });

    return await _httpUtils.safeApiCall(() async {
      final response = await dio.post(ApiConfig.updateProfile, data: formData);
      return UpdateProfileResponse.fromJson(response.data);
    });
  }

  Future<GetProfileResponse> getProfile() async {
    final dio = await _httpUtils.initDio();

    return await _httpUtils.safeApiCall(() async {
      final response = await dio.get(ApiConfig.getProfile);
      return GetProfileResponse.fromJson(response.data);
    });
  }

  Future<GetChildrenProfileResponse> getChildrenProfile() async {
    final dio = await _httpUtils.initDio();

    return await _httpUtils.safeApiCall(() async {
      final response = await dio.get(ApiConfig.getChildProfile);
      return GetChildrenProfileResponse.fromJson(response.data);
    });
  }

  Future<GetChildProfileResponse> getChildProfile({
    required int id,
  }) async {
    final dio = await _httpUtils.initDio();

    return await _httpUtils.safeApiCall(() async {
      final response = await dio.get(ApiConfig.getChildProfile + "/${id}");
      return GetChildProfileResponse.fromJson(response.data);
    });
  }

  Future<CreateChildProfileResponse> createChildProfile({
    required String username,
    required String password,
    required String passwordConfirmation,
    required String name,
    required String dateOfBirth,
    required String gender,
    required String liveWithParents,
    required String grade,
    required String school,
  }) async {
    final dio = await _httpUtils.initDio();

    final formData = FormData.fromMap({
      "username": username,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "name": name,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "live_with_parents": liveWithParents,
      "grade": grade,
      "school": school,
    });

    return await _httpUtils.safeApiCall(() async {
      final response =
          await dio.post(ApiConfig.createChildProfile, data: formData);
      return CreateChildProfileResponse.fromJson(response.data);
    });
  }

  Future<UpdateChildProfileResponse> updateChildProfile({
    required String name,
    required String dateOfBirth,
    required String gender,
    required String liveWithParents,
    required String grade,
    required String school,
    required int id,
  }) async {
    final dio = await _httpUtils.initDio();

    final data = {
      "name": name,
      "date_of_birth": dateOfBirth,
      "gender": gender,
      "live_with_parents": liveWithParents,
      "grade": grade,
      "school": school,
    };

    return await _httpUtils.safeApiCall(() async {
      final response =
          await dio.put(ApiConfig.updateChildProfile + "/${id}", data: data);
      return UpdateChildProfileResponse.fromJson(response.data);
    });
  }

  Future<ChildPreferenceResponse> addChildPreference({
    required int id,
    required List<String> favoritePhysicalActivities,
    required List<String> hobbies,
    required List<String> favoriteFamilyActivities,
    required List<String> favoriteOnlineActivities,
  }) async {
    final dio = await _httpUtils.initDio();

    final data = {
      "favorite_physical_activities": favoritePhysicalActivities,
      "hobbies": hobbies,
      "favorite_family_activities": favoriteFamilyActivities,
      "favorite_online_activities": favoriteOnlineActivities,
    };

    return await _httpUtils.safeApiCall(() async {
      final response = await dio.post(
        "${ApiConfig.getChildProfile}/$id/set-preference",
        data: data,
      );
      print(response);
      return ChildPreferenceResponse.fromJson(response.data);
    });
  }

  Future<AvatarListResponse> getChildAvatarList({
    required String gender
  }) async {
    final dio = await _httpUtils.initDio();

    return await _httpUtils.safeApiCall(() async {
      final response = await dio.get(
          "${ApiConfig.avatarList}?gender=${gender}&role=children"
      );
      print("child avatar respone ${response}");
      return AvatarListResponse.fromJson(response.data);
    });
  }

  Future<UpdateChildAvatarResponse> updateChildAvatar({
    required int childProfileId,
    required int avatarId,
  }) async {
    final dio = await _httpUtils.initDio();

    final data = {
      "avatar_id": avatarId,
    };

    return await _httpUtils.safeApiCall(() async {
      final response = await dio.post(
        "${ApiConfig.getChildProfile}/$childProfileId/set-avatar",
        data: data,
      );
      print(response);
      return UpdateChildAvatarResponse.fromJson(response.data);
    });
  }
}
