import 'dart:convert';

import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:online_pal_guardians/utils/string_value.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionHelper {
  late SharedPreferences prefs;

  saveToken(String accessToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(StringValue.access_token, accessToken);
  }

  Future<String?> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(StringValue.access_token);
  }

  deleteToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(StringValue.access_token);
  }

  Future<void> saveGender(String gender) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(StringValue.gender, gender);
  }

  Future<String?> getGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(StringValue.gender);
  }

  Future<void> saveChildGender(String gender) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(StringValue.child_gender, gender);
  }

  Future<String?> getChildGender() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(StringValue.child_gender);
  }

  Future<void> saveChildProfile(ChildProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(profile.toJson());
    await prefs.setString('child_profile', jsonString);
  }

  Future<ChildProfile?> getChildProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('child_profile');

    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return ChildProfile.fromJson(jsonMap);
    }
    return null;
  }

  Future<void> setGuardianProfileFilled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('profile_guardian_filled', value);
  }

  Future<bool> isGuardianProfileFilled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('profile_guardian_filled') ?? false;
  }

  Future<void> setChildProfileFilled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('profile_child_filled', value);
  }

  Future<bool> isChildProfileFilled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('profile_child_filled') ?? false;
  }

  Future<void> setPreferenceProfileFilled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('profile_preference_filled', value);
  }

  Future<bool> isPreferenceProfileFilled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('profile_preference_filled') ?? false;
  }

  Future<void> saveProfileId(int profileId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('profile_id', profileId);
  }

  Future<int?> getProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('profile_id');
  }

  Future<void> deleteProfileId() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile_id');
  }

  Future<void> clearAllPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
