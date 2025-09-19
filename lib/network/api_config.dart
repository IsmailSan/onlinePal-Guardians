import 'package:online_pal_guardians/utils/flavor_config.dart';

class ApiConfig {
  static String baseUrl = FlavorConfig.instance?.values?.baseUrl ?? "";

  static String api = "/api";

  static String login = "$baseUrl$api/login";
  static String register = "$baseUrl$api/register";
  static String logout = "$baseUrl$api/logout";

  static String updateProfile = "$baseUrl$api/parent/profile/update";
  static String getProfile = "$baseUrl$api/parent/profile";
  static String updateAvatar = "$baseUrl$api/parent/profile/update-avatar";
  static String avatarList = "$baseUrl$api/list-avatar";

  static String createChildProfile = "$baseUrl$api/parent/children/create";
  static String updateChildProfile = "$baseUrl$api/parent/children/update";
  static String getChildProfile = "$baseUrl$api/parent/children";

  static String home = "$baseUrl$api/parent/dashboard";

  static String suggestedMissionList =
      "$baseUrl$api/parent/mission/mission-sugestion";
  static String createMissionFromSuggestion =
      "$baseUrl$api/parent/mission/add-from-suggestion";
  static String deleteMission = "$baseUrl$api/parent/mission/delete-mission";
  static String updateMission =
      "$baseUrl$api/parent/mission/update-manual-mission";
  static String missionList = "$baseUrl$api/parent/mission/list";
  static String createNewMission =
      "$baseUrl$api/parent/mission/add-manual-mission";
  static String createAllMissionFromMission =
      "$baseUrl$api/parent/mission/add-all-from-suggestion";

  static String notificationList = "$baseUrl$api/parent/notification/list";
  static String markAsReadNotification =
      "$baseUrl$api/parent/notification/mark-as-read";

  static String createSchedule = "$baseUrl$api/parent/schedule/add";
  static String updateSchedule = "$baseUrl$api/children/schedule/edit";
  static String scheduleList = "$baseUrl$api/parent/schedule/list";
  static String suggestedSchedules =
      "$baseUrl$api/parent/schedule/schedules-sugestion";

  static String reward = "$baseUrl$api/parent/reward";
  static String punishment = "$baseUrl$api/parent/punishment";
  static String createReward = "$baseUrl$api/parent/reward/create";
  static String updateReward = "$baseUrl$api/parent/reward/update";
  static String createPunishment = "$baseUrl$api/parent/punishment/create";
  static String updatePunishment = "$baseUrl$api/parent/punishment/update";
  static String rewardList = "$baseUrl$api/parent/reward/list";
  static String punishmentList = "$baseUrl$api/parent/punishment/list";
  static String deleteReward = "$baseUrl$api/parent/reward/delete";
  static String deletePunishment = "$baseUrl$api/parent/punishment/delete";

  static String getScreenActivity =
      "$baseUrl$api/parent/monitoring/screen-activity";
  static String getScreenTime = "$baseUrl$api/parent/monitoring/screen-time";

  static String appCategoryList = "$baseUrl$api/list-app-category";
  static String appList = "$baseUrl$api/list-app";
}
