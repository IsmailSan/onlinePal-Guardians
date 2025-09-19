import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:online_pal_guardians/models/schedule/suggested_schedules_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/schedule/schedule_input_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/utils/text_utils.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';

class FindActivityScreen extends StatefulWidget {
  const FindActivityScreen({Key? key}) : super(key: key);

  @override
  State<FindActivityScreen> createState() => _FindActivityScreenState();
}

class _FindActivityScreenState extends State<FindActivityScreen> {
  List<SuggestedSchedule>? suggestedSchedules;
  late ScrollController _scrollController;
  bool _isFetchingMore = false;
  String? _nextCursor;
  ChildProfile? selectedProfile;


  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    context.read<ScheduleBloc>().add(ScheduleInitialized());
    context.read<ScheduleBloc>().add(GetSuggestedSchedules(
      search: '',
    ));
  }

  void _onScroll() async {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100 &&
        !_isFetchingMore &&
        _nextCursor != null) {
      setState(() {
        _isFetchingMore = true;
      });

      context.read<ScheduleBloc>().add(GetSuggestedSchedules(
        search: '',
        cursor: _nextCursor,
        isRefresh: false,
      ));
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
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.h, right: 16, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Inspirasi Aktivitas",
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
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
                SizedBox(height: 60.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                                fontSize: 17.sp, fontWeight: bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 10.w),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Cari Sesuatu",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    // Expanded(
                    //   flex: 1,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       showDialog(
                    //         context: context,
                    //         builder: (BuildContext context) {
                    //           return const SearchFilterDialog();
                    //         },
                    //       );
                    //     },
                    //     child: SvgPicture.asset(
                    //       'assets/filter_icon.svg',
                    //       width: 24.w,
                    //       height: 24.h,
                    //       fit: BoxFit.contain,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 20.h),
                Text(
                  'Kegiatan positif untuk laki-laki keren...',
                  style: blackTextStyle.copyWith(
                      fontSize: 17.sp, fontWeight: regular, fontStyle: italic),
                ),
                Expanded(
                  child: BlocConsumer<ScheduleBloc, ScheduleState>(
                    listener: (context, state) {
                      if (state is ScheduleError) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => ErrorDialog(message: state.message),
                        );
                      } else if (state is SuggestedSchedulesSuccess) {
                        _isFetchingMore = false;
                        _nextCursor = state
                            .suggestedSchedulesResponse.data.nextCursor
                            ?.toString();
                      }
                    },
                    builder: (context, state) {
                      if (state is SuggestedSchedulesSuccess) {
                        suggestedSchedules =
                            state.suggestedSchedulesResponse.data.data;
                      }
                        if (suggestedSchedules == null || suggestedSchedules!.isEmpty) {
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
                                  'Aktifitas tidak tersedia',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16.sp, fontWeight: bold),
                                ),
                              ],
                            ),
                          );
                        }

                        if (suggestedSchedules != null) {
                          return ListView.builder(
                            controller: _scrollController,
                            itemCount: suggestedSchedules?.length,
                            itemBuilder: (context, index) {
                              final suggestedSchedule = suggestedSchedules?[index];
                              return _buildFindActivityItem(suggestedSchedule!, index+1);
                            },
                          );
                        }

                      return const SizedBox.shrink(); // Default fallback
                    },
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<ScheduleBloc, ScheduleState>(
            builder: (context, state) {
              if (state is ScheduleLoading) {
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

    Widget _buildFindActivityItem(SuggestedSchedule schedule, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$index. ",
                  style: blackTextStyle.copyWith(
                      fontSize: 20.sp, fontWeight: medium),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        schedule.name ?? "",
                        style: blackTextStyle.copyWith(
                            fontSize: 15.sp, fontWeight: medium),
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        formatDateToDDMMYYYY(schedule.createdAt ?? ""),
                        style: blackTextStyle.copyWith(
                            fontSize: 12.sp, fontWeight: medium),
                      ),
                      // SizedBox(height: 4.h),
                      // Text(
                      //   truncateText(activity.periodeTime, 32),
                      //   style: grayTextStyle.copyWith(
                      //       fontSize: 12.sp, fontWeight: regular),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ScheduleInputScreen(suggestedSchedule: schedule.name,)));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purpleColor,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      "Pilih",
                      style: whiteTextStyle.copyWith(
                          fontSize: 15.sp, fontWeight: medium),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
