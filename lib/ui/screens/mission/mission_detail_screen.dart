import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_event.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_state.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/mission/dialog/confirm_delete_mission_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class MissionDetailScreen extends StatefulWidget {
  final String? status;

  const MissionDetailScreen({Key? key, this.status}) : super(key: key);

  @override
  State<MissionDetailScreen> createState() => _MissionDetailScreenState();
}

class _MissionDetailScreenState extends State<MissionDetailScreen> {
  ChildProfile? selectedProfile;
  List<Mission>? missions;
  late ScrollController _scrollController;
  bool _isFetchingMore = false;
  String? _nextCursor;
  int? selectedProfileId;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    final profile = await SessionHelper().getChildProfile();
    final childUserId = profile?.userId;
    context.read<MissionBloc>().add(MissionInitialized());
    if (childUserId != null) {
      context.read<MissionBloc>().add(GetMissions(
            childrenId: childUserId,
            status: widget.status ?? "",
          ));
    }
  }

  void _onScroll() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isFetchingMore &&
        _nextCursor != null) {
      setState(() {
        _isFetchingMore = true;
      });

      final profile = await SessionHelper().getChildProfile();
      final childUserId = profile?.userId;

      if (childUserId != null) {
        context.read<MissionBloc>().add(GetMissions(
              childrenId: childUserId,
              status: widget.status ?? "",
              cursor: _nextCursor,
              isRefresh: false,
            ));
      }
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
                      widget.status == "active"
                          ? "Misi Aktif"
                          : widget.status == "completed"
                              ? "Riwayat Misi"
                              : widget.status == "waiting"
                                  ? "Misi Menunggu Konfirmasi"
                                  : "Buat Misi Baru",
                      style: blackTextStyle.copyWith(
                        fontSize: 20.sp,
                        fontWeight: bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Row(
                      children: [
                        ChildProfileSelector(
                          onProfileChanged: (profile) {
                            context
                                .read<MissionBloc>()
                                .add(MissionInitialized());
                            context.read<MissionBloc>().add(GetMissions(
                                  childrenId: profile.userId,
                                  status: widget.status ?? "",
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
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      const Icon(Icons.arrow_back_ios,
                          size: 18.0, color: Colors.black),
                      SizedBox(width: 4.w),
                      Text(
                        'Kembali',
                        style: blackTextStyle.copyWith(
                            fontSize: 16.sp, fontWeight: bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: BlocConsumer<MissionBloc, MissionState>(
                    listener: (context, state) {
                      if (state is MissionError) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => ErrorDialog(message: state.message),
                        );
                      } else if (state is MissionListSuccess) {
                        _isFetchingMore = false;
                        _nextCursor = state
                            .missionsByStatus[widget.status]?.data.nextCursor
                            ?.toString();
                      }
                    },
                    builder: (context, state) {
                      if (state is MissionListSuccess) {
                        missions =
                            state.missionsByStatus[widget.status]?.data.data ??
                                [];

                        if (missions == null || missions!.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'assets/no_data.png',
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Misi tidak tersedia',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16.sp, fontWeight: bold),
                                ),
                              ],
                            ),
                          );
                        }

                        if (missions != null) {
                          return Container(
                            height: 20.h,
                            margin: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [softBlueColor, purpleColor],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: missions?.length,
                              itemBuilder: (context, index) {
                                final mission = missions?[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${index + 1}.",
                                        style: blackTextStyle.copyWith(
                                            fontSize: 15.sp),
                                      ),
                                      SizedBox(width: 8.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              mission?.name ??
                                                  'Judul tidak tersedia',
                                              style: blackTextStyle.copyWith(
                                                  fontSize: 15.sp),
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
                                            Divider(
                                                color: Colors.black,
                                                height: 0.5),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 8.w),
                                      Row(
                                        children: widget.status == "completed"
                                            ? [
                                                Container(
                                                  padding: EdgeInsets.all(13.w),
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: Colors.indigo),
                                                  child: Text(
                                                    "Detail",
                                                    style:
                                                        whiteTextStyle.copyWith(
                                                            fontSize: 14.sp),
                                                  ),
                                                ),
                                              ]
                                            : [
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .pushNamed(
                                                      _getRouteFromStatus(
                                                          widget.status ?? ""),
                                                      arguments: mission,
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(13.w),
                                                    decoration: BoxDecoration(
                                                        color: purpleColor),
                                                    child: Icon(Icons.settings,
                                                        size: 18.sp,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (_) =>
                                                          ConfirmDeleteMissionDialog(
                                                              missionId:
                                                                  mission!.id ??
                                                                      0),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.all(13.w),
                                                    decoration:
                                                        const BoxDecoration(
                                                            color: Colors.red),
                                                    child: Icon(Icons.delete,
                                                        size: 18.sp,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          );
                        }
                      }
                      return const Center();
                    },
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<MissionBloc, MissionState>(
            builder: (context, state) {
              if (state is MissionLoading || state is DeleteMissionLoading) {
                return Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const LoadingDialog(),
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
