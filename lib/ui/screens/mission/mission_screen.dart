import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_event.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_state.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
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
  int? missionId;
  List<Mission>? missions;
  late ScrollController _scrollController;
  bool _isFetchingMore = false;
  int? selectedProfileId;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final profile = await SessionHelper().getChildProfile();
      final childUserId = profile?.userId;

      context.read<MissionBloc>().add(MissionInitialized());
      if (childUserId != null) {
        context.read<MissionBloc>().add(
            GetMissions(childrenId: childUserId, status: widget.status ?? ""));
      }
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isFetchingMore) {
      final bloc = context.read<MissionBloc>();
      final state = bloc.state;

      if (state is MissionListSuccess) {
        final missionsData = state.missionsByStatus[widget.status]?.data;
        final nextCursor = missionsData?.nextCursor;

        if (nextCursor != null) {
          setState(() {
            _isFetchingMore = true;
          });

          bloc.add(
            GetMissions(
              childrenId: 3,
              status: widget.status ?? "",
              isRefresh: false,
            ),
          );
        }
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
                          fontSize: 20.sp, fontWeight: bold, fontStyle: italic),
                    ),
                    Row(
                      children: [
                        ChildProfileSelector(),
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message),
                            backgroundColor: redColor,
                          ),
                        );
                      }
                      if (state is MissionListSuccess) {
                        _isFetchingMore = false;
                      }
                    },
                    builder: (context, state) {
                      if (state is MissionListSuccess) {
                        final missions =
                            state.missionsByStatus[widget.status]?.data?.data ??
                                [];

                        if (missions.isEmpty) {
                          return Center(
                            child: Text(
                              'Belum ada misi untuk saat ini.',
                              style: blackTextStyle.copyWith(fontSize: 16.sp),
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: missions.length + 1,
                          itemBuilder: (context, index) {
                            if (index == missions.length) {
                              final nextCursor = state
                                  .missionsByStatus[widget.status]
                                  ?.data
                                  ?.nextCursor;
                              if (nextCursor != null &&
                                  nextCursor.toString().isNotEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                );
                              } else {
                                return const SizedBox.shrink();
                              }
                            }

                            final mission = missions[index];
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [softBlueColor, purpleColor],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${index + 1}.",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 15.sp),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mission.name ??
                                                'Judul tidak tersedia',
                                            style: blackTextStyle.copyWith(
                                                fontSize: 15.sp),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            "Periode: ${mission.periodeTime ?? 'N/A'}",
                                            style: blackTextStyle.copyWith(
                                              fontSize: 10.sp,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Divider(color: Colors.black),
                                        ],
                                      ),
                                    ),
                                    // ... tombol settings dan delete seperti sebelumnya
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                )
              ],
            ),
          ),
          BlocBuilder<MissionBloc, MissionState>(
            builder: (context, state) {
              if (state is MissionLoading) {
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
