import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_event.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_state.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/mission/active_mission_screen.dart';
import 'package:online_pal_guardians/ui/screens/mission/create_new_suggested_mission_screen.dart';
import 'package:online_pal_guardians/ui/screens/mission/dialog/confirm_delete_mission_dialog.dart';
import 'package:online_pal_guardians/ui/screens/mission/dialog/new_mission_dialog.dart';
import 'package:online_pal_guardians/ui/screens/mission/inactive_mission_screen.dart';
import 'package:online_pal_guardians/ui/screens/mission/mission_detail_screen.dart';
import 'package:online_pal_guardians/ui/screens/mission/mission_edit_screen.dart';
import 'package:online_pal_guardians/ui/screens/mission/mission_history_screen.dart';
import 'package:online_pal_guardians/ui/screens/mission/mission_pending_confirmation_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:online_pal_guardians/ui/widgets/success_dialog.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class ChildMissionScreen extends StatefulWidget {
  const ChildMissionScreen({Key? key}) : super(key: key);

  @override
  State<ChildMissionScreen> createState() => _ChildMissionScreenState();
}

class _ChildMissionScreenState extends State<ChildMissionScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  ChildProfile? selectedProfile;
  int? selectedProfileId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final profile = await SessionHelper().getChildProfile();
      final childUserId = profile?.userId;

      if (childUserId != null) {
        context.read<MissionBloc>().add(MissionInitialized());
        context
            .read<MissionBloc>()
            .add(GetMissions(childrenId: childUserId, status: "active"));
        context
            .read<MissionBloc>()
            .add(GetMissions(childrenId: childUserId, status: "waiting"));
        context.read<MissionBloc>().add(GetMissionsHistory(
              childrenId: childUserId,
            ));
      }
    });
  }

  void _refreshMissions() async {
    final profile = await SessionHelper().getChildProfile();
    final childUserId = profile?.userId;

    if (childUserId != null) {
      context.read<MissionBloc>().add(GetMissions(
          childrenId: childUserId, status: "active", isRefresh: true));
      context.read<MissionBloc>().add(GetMissions(
          childrenId: childUserId, status: "waiting", isRefresh: true));
      context.read<MissionBloc>().add(GetMissionsHistory(
            childrenId: childUserId,
          ));
    }
  }

  String _getRouteFromStatus(String status) {
    switch (status) {
      case "active":
        return '/activeMission';
      case "waiting":
        return '/missionPendingConfirmation';
      case "completed":
        return '/missionHistory';
      default:
        return '/missionUnknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _navigatorKey.currentState?.canPop() ?? false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _navigatorKey.currentState!.canPop()) {
          _navigatorKey.currentState!.pop();
        }
        if (result != null) {
          //
        }
      },
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          final args = settings.arguments;
          switch (settings.name) {
            case '/activeMission':
              return MaterialPageRoute(
                builder: (_) => ActiveMissionScreen(mission: args as Mission),
                settings: const RouteSettings(name: '/activeMission'),
              );
            case '/inactiveMission':
              return MaterialPageRoute(
                builder: (_) => InActiveMissionScreen(mission: args as Mission),
                settings: const RouteSettings(name: '/inactiveMission'),
              );
            case '/missionPendingConfirmation':
              return MaterialPageRoute(
                builder: (_) =>
                    MissionPendingConfirmationScreen(mission: args as Mission),
                settings:
                    const RouteSettings(name: '/missionPendingConfirmation'),
              );
            case '/missionEdit':
              return MaterialPageRoute(
                builder: (_) => MissionEditScreen(mission: args as Mission),
                settings: const RouteSettings(name: '/missionEdit'),
              );
            case '/missionHistory':
              return MaterialPageRoute(
                builder: (_) => const MissionHistoryScreen(),
                settings: const RouteSettings(name: '/missionHistory'),
              );
            case '/missionDetail':
              return MaterialPageRoute(
                builder: (_) => MissionDetailScreen(status: args as String),
                settings: const RouteSettings(name: '/missionDetail'),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => _buildChildMission(),
                settings: const RouteSettings(name: '/'),
              );
          }
        },
      ),
    );
  }

  Widget _buildChildMission() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/top_bg_wave.png',
              fit: BoxFit.cover,
              height: 150.h,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 21, left: 21, top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Misi Penggunaan Gadget",
                      style: blackTextStyle.copyWith(
                          fontSize: 20.sp, fontWeight: bold, fontStyle: italic),
                    ),
                    Row(
                      children: [
                        ChildProfileSelector(
                          onProfileChanged: (profile) async {
                            await SessionHelper().saveChildProfile(profile);

                            context.read<MissionBloc>().add(GetMissions(
                                childrenId: profile.userId ?? 0,
                                status: "active",
                                isRefresh: true));
                            context.read<MissionBloc>().add(GetMissions(
                                childrenId: profile.userId ?? 0,
                                status: "waiting",
                                isRefresh: true));
                            context.read<MissionBloc>().add(GetMissionsHistory(
                                  childrenId: profile.userId ?? 0,
                                ));
                          },
                        ),
                        SizedBox(width: 14.w),
                        MoreOptionsDropdown(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                // GestureDetector(
                //   onTap: () => Navigator.pop(context),
                //   child: Row(
                //     children: [
                //       const Icon(Icons.arrow_back_ios,
                //           size: 18.0, color: Colors.black),
                //       SizedBox(width: 4.w),
                //       Text(
                //         'Kembali',
                //         style: blackTextStyle.copyWith(
                //             fontSize: 16.sp, fontWeight: bold),
                //       ),
                //     ],
                //   ),
                // ),
                SizedBox(height: 20.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () => NewMissionDialog.show(context),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [Color(0xFF94A6F5), Colors.indigo],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Bagaimana cara membuat misi?",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12.sp, fontWeight: bold),
                                    ),
                                    SizedBox(height: 4.h),
                                    SvgPicture.asset(
                                      'assets/triangle_circle.svg',
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CreateNewSuggestedMissionScreen(),
                                    ),
                                  );
                                  if (result == true) {
                                    _refreshMissions();
                                  }
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.black),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: Colors.white,
                                ),
                                child: Text(
                                  'Buat misi baru',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 20.sp, fontWeight: bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 22.h),
                            _buildMissionSection(
                              title: "Misi Aktif",
                              status: "active",
                            ),
                            SizedBox(height: 22.h),
                            _buildMissionSection(
                              title: "Misi Menunggu Konfirmasi",
                              status: "waiting",
                            ),
                            SizedBox(height: 22.h),
                            _buildMissionSection(
                              title: "Riwayat Misi",
                              status: "completed",
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
          BlocListener<MissionBloc, MissionState>(
            listener: (context, state) async {
              if (state is DeleteMissionSuccess) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      SuccessDialog(message: 'Misi Berhasil Dihapus'),
                );
                final profile = await SessionHelper().getChildProfile();
                final childUserId = profile?.userId;

                if (childUserId != null) {
                  context.read<MissionBloc>().add(MissionInitialized());
                  context.read<MissionBloc>().add(
                      GetMissions(childrenId: childUserId, status: "active"));
                  context.read<MissionBloc>().add(
                      GetMissions(childrenId: childUserId, status: "waiting"));
                  context.read<MissionBloc>().add(GetMissionsHistory(
                        childrenId: childUserId,
                      ));
                }
              } else if (state is MissionError) {
                ErrorDialog(message: state.message);
              }
            },
            child: BlocBuilder<MissionBloc, MissionState>(
              builder: (context, state) {
                if (state is DeleteMissionLoading || state is MissionLoading) {
                  return const LoadingDialog();
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection({
    required String title,
    required String status,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [softBlueColor, purpleColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: medium,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<MissionBloc, MissionState>(
            buildWhen: (previous, current) {
              if (current is MissionListSuccess &&
                  current.missionsByStatus.containsKey(status)) {
                return true;
              }
              if (current is MissionLoading) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if ((status == "active" && state is ActiveMissionLoading) ||
                  (status == "waiting" && state is WaitingMissionLoading) ||
                  (status == "completed" && state is MissionHistoryLoading)) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MissionListSuccess) {
                final missions =
                    state.missionsByStatus[status]?.data?.data ?? [];

                final top4Missions = missions.take(4).toList();
                if (missions.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada misi.',
                      style: blackTextStyle.copyWith(fontSize: 16.sp),
                    ),
                  );
                }
                return SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: top4Missions.length,
                        itemBuilder: (context, index) {
                          final mission = top4Missions[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}.",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mission.name ?? 'Judul tidak tersedia',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        "Periode: ${mission.periodeTime ?? 'N/A'}",
                                        style: blackTextStyle.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Container(
                                        height: 0.5,
                                        width: double.infinity,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                GestureDetector(
                                  onTap: () {
                                    _navigatorKey.currentState!.pushNamed(
                                      _getRouteFromStatus(status),
                                      arguments: mission,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(13.w),
                                    decoration:
                                        BoxDecoration(color: purpleColor),
                                    child: Icon(
                                      Icons.settings,
                                      size: 18.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ConfirmDeleteMissionDialog(
                                              missionId: mission?.id ?? 0),
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(13.w),
                                    decoration:
                                        const BoxDecoration(color: Colors.red),
                                    child: Icon(
                                      Icons.delete,
                                      size: 18.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      GestureDetector(
                        onTap: () {
                          _navigatorKey.currentState!.pushNamed(
                            '/missionDetail',
                            arguments: status,
                          );
                        },
                        child: Center(
                          child: Text(
                            'Lainnya',
                            style: blackTextStyle.copyWith(
                              fontSize: 15.sp,
                              fontWeight: bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMissionHistorySection({
    required String title,
    required String status,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [softBlueColor, purpleColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: medium,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<MissionBloc, MissionState>(
            buildWhen: (previous, current) {
              if (current is MissionHistoryListSuccess) {
                return true;
              }
              if (current is MissionLoading) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if (state is MissionLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is MissionHistoryListSuccess) {
                final missions = state.response.data?.data;

                final top4Missions = missions?.take(4).toList();
                if (missions == null || missions!.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada misi.',
                      style: blackTextStyle.copyWith(fontSize: 16.sp),
                    ),
                  );
                }
                return SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: top4Missions?.length,
                        itemBuilder: (context, index) {
                          final mission = top4Missions?[index];
                          return Container(
                            margin: EdgeInsets.only(bottom: 8.h),
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}.",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mission?.name ?? 'Judul tidak tersedia',
                                        style: blackTextStyle.copyWith(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        "Periode: ${mission?.periodeTime ?? 'N/A'}",
                                        style: blackTextStyle.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Container(
                                        height: 0.5,
                                        width: double.infinity,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                GestureDetector(
                                  onTap: () {
                                    _navigatorKey.currentState!.pushNamed(
                                      '/inactiveMission',
                                      arguments: mission,
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(13.w),
                                    decoration: const BoxDecoration(
                                      color: Colors.indigo,
                                    ),
                                    child: Text(
                                      "Detail",
                                      style: whiteTextStyle.copyWith(
                                        fontSize: 14.sp,
                                        fontWeight: medium,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      GestureDetector(
                        onTap: () {
                          _navigatorKey.currentState!.pushNamed(
                            '/missionDetail',
                            arguments: status,
                          );
                        },
                        child: Center(
                          child: Text(
                            'Lainnya',
                            style: blackTextStyle.copyWith(
                              fontSize: 15.sp,
                              fontWeight: bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
