import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_event.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_state.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/mission/inactive_mission_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class MissionHistoryScreen extends StatefulWidget {
  const MissionHistoryScreen({Key? key}) : super(key: key);

  @override
  State<MissionHistoryScreen> createState() => _MissionHistoryScreenState();
}

class _MissionHistoryScreenState extends State<MissionHistoryScreen> {
  int? missionId;
  List<Mission>? missions;
  late ScrollController _scrollController;
  bool _isFetchingMore = false;
  int? _nextCursor;

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
      context.read<MissionBloc>().add(GetMissionsHistory(
        childrenId: childUserId,
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
        context.read<MissionBloc>().add(GetMissionsHistory(
          childrenId: childUserId,
          cursor: _nextCursor.toString(),
          isRefresh: false,
        ));
      }
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
                      "Riwayat Misi",
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
                  onTap: () => Navigator.pop(context, true),
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
                  child: Column(children: [
                    Center(
                      child: Column(
                        children: [
                          SizedBox(height: 22.h),
                          Container(
                            height: 0.7.sh,
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
                                SizedBox(height: 12.h),
                                BlocConsumer<MissionBloc, MissionState>(
                                  listener: (context, state) {
                                    if (state is MissionHistoryListSuccess) {
                                      _isFetchingMore = false;
                                      _nextCursor =
                                          state.response.data.nextCursor;
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is MissionHistoryListSuccess) {
                                      missions = state.response.data.data ??
                                          [];
                                    }
                                    if (missions != null) {
                                      return Expanded(
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          itemCount: missions?.length,
                                          itemBuilder: (context, index) {
                                            final mission = missions?[index];
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 8.h),
                                              padding: EdgeInsets.all(8.w),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${index + 1}.",
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 15.sp,
                                                      fontWeight: regular,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          mission?.name ?? "",
                                                          style: blackTextStyle
                                                              .copyWith(
                                                            fontSize: 15.sp,
                                                            fontWeight: regular,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4.h),
                                                        Text(
                                                          "Periode: ${mission?.periodeTime}",
                                                          style: blackTextStyle
                                                              .copyWith(
                                                            fontSize: 10.sp,
                                                            fontWeight: light,
                                                            fontStyle: FontStyle
                                                                .italic,
                                                          ),
                                                        ),
                                                        SizedBox(height: 4.h),
                                                        Container(
                                                          height: 0.5,
                                                          width:
                                                              double.infinity,
                                                          color: Colors.black,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(width: 8.w),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                              InActiveMissionScreen(mission: mission,)));
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
                                      );
                                    }
                                    return Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: 20.h),
                                          Image.asset(
                                            'assets/no_data.png',
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.contain,
                                          ),
                                          const SizedBox(height: 12),
                                          Text(
                                            'Misi tidak tersedia',
                                            style: blackTextStyle.copyWith(
                                                fontSize: 16.sp,
                                                fontWeight: bold),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      ),
                    ),
                  ]),
                ),
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
