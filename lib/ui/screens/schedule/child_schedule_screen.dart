import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:online_pal_guardians/models/schedule/schedule_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/schedule/dialog/schedule_detail_dialog.dart';
import 'package:online_pal_guardians/ui/screens/schedule/find_activity_screen.dart';
import 'package:online_pal_guardians/ui/screens/schedule/schedule_input_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class ChildScheduleScreen extends StatefulWidget {
  const ChildScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ChildScheduleScreen> createState() => _ChildScheduleScreenState();
}

class _ChildScheduleScreenState extends State<ChildScheduleScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int currentWeekIndex = 0;
  String childName = '';
  ChildProfile? selectedProfile;
  DateTime today = DateTime.now();
  List<List<Schedule?>> activityGrid =
      List.generate(24, (_) => List.generate(7, (_) => null));

  DateTime get startOfWeek => today.subtract(Duration(days: today.weekday - 1));

  String getMonthName(int month) {
    const months = [
      '',
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month];
  }

  final List<String> weekDays = [
    "Sen",
    "Sel",
    "Rab",
    "Kam",
    "Jum",
    "Sab",
    "Min",
  ];

  Map<String, String> getFormattedDateStartAndEnd() {
    DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
    DateTime startDate = startOfWeek.add(Duration(days: currentWeekIndex * 7));
    DateTime endDate = startDate.add(const Duration(days: 6));

    String getDisplayFormat(DateTime date) {
      String month = getMonthName(date.month);
      String shortMonth = month.length > 4 ? month.substring(0, 4) : month;
      return '${date.day} $shortMonth ${date.year}';
    }

    String getApiFormat(DateTime date) {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }

    return {
      'dateStart': getApiFormat(startDate),
      'dateEnd': getApiFormat(endDate),
      'dateStartDisplay': getDisplayFormat(startDate),
      'dateEndDisplay': getDisplayFormat(endDate),
    };
  }

  void clearActivityGrid() {
    for (int i = 0; i < 24; i++) {
      for (int j = 0; j < 7; j++) {
        activityGrid[i][j] = null;
      }
    }
  }

  DateTime getStartOfWeekForCurrentIndex() {
    final now = DateTime.now();
    final thisWeekStart = now.subtract(Duration(days: now.weekday - 1));
    return thisWeekStart.add(Duration(days: currentWeekIndex * 7));
  }

  void populateActivities(List<Schedule> items, DateTime startOfWeek) {
    for (var item in items) {
      final start = _parseDateTime(item.date, item.timeStart);
      final end = _parseDateTime(item.date, item.timeEnd);

      int dayIndex = start.difference(startOfWeek).inDays;
      int hourIndex = start.hour;

      if (dayIndex >= 0 && dayIndex < 7 && hourIndex >= 0 && hourIndex < 24) {
        activityGrid[hourIndex][dayIndex] = Schedule(
          id: item.id,
          date: item.date,
          timeStart: item.timeStart,
          timeEnd: item.timeEnd,
          scheduleItemId: item.scheduleItemId,
          customCategory: item.customCategory,
          customIcon: item.customIcon,
          customColor: item.customColor,
          notes: item.notes,
          createdById: item.createdById,
          customName: item.customName ?? "-",
          createdAt: item.createdAt ?? "",
          childrenId: item.childrenId,
          updatedAt: item.updatedAt,
        );
      }
    }
  }

  DateTime _parseDateTime(String date, String time) {
    final hour = int.parse(time.substring(0, 2));
    final minute = int.parse(time.substring(2, 4));

    final dateParts = date.split('-');
    final year = int.parse(dateParts[0]);
    final month = int.parse(dateParts[1]);
    final day = int.parse(dateParts[2]);

    return DateTime(year, month, day, hour, minute);
  }

  String getWeekdayShortName(int weekday) {
    const names = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    return names[(weekday - 1) % 7];
  }

  String formatHHmm(String rawTime) {
    if (rawTime.length != 4) return rawTime;
    final hour = rawTime.substring(0, 2);
    final minute = rawTime.substring(2, 4);
    return '$hour:$minute';
  }

  String buildSimpleTimeRange(String date, String timeStart, String timeEnd) {
    final dateParts = date.split('-').map(int.parse).toList();
    final dt = DateTime(dateParts[0], dateParts[1], dateParts[2]);
    final dayName = getWeekdayShortName(dt.weekday);
    return "$dayName ${formatHHmm(timeStart)} - ${formatHHmm(timeEnd)}";
  }

  String formatLastUpdate(String updatedAt, String updatedBy) {
    final dateTime = DateTime.parse(updatedAt);
    final hari = dateTime.day.toString().padLeft(2, '0');
    final bulan = getMonthName(dateTime.month);
    final tahun = dateTime.year;
    final jam = dateTime.hour.toString().padLeft(2, '0');
    final menit = dateTime.minute.toString().padLeft(2, '0');

    return '$hari $bulan $tahun, $jam:$menit by $updatedBy';
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    final profile = await SessionHelper().getChildProfile();
    final childUserId = profile?.userId;
    final name = profile?.name;
    setState(() {
      childName = name ?? "";
    });
    final dates = getFormattedDateStartAndEnd();

    context.read<ScheduleBloc>().add(ScheduleInitialized());

    if (childUserId != null) {
      context.read<ScheduleBloc>().add(
            GetScheduleList(
              childrenId: childUserId,
              dateStart: dates['dateStart']!,
              dateEnd: dates['dateEnd']!,
            ),
          );
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
          switch (settings.name) {
            case '/findActivity':
              return MaterialPageRoute(
                builder: (_) => const FindActivityScreen(),
                settings: const RouteSettings(name: '/findActivity'),
              );
            case '/scheduleInput':
              return MaterialPageRoute(
                builder: (_) => const ScheduleInputScreen(),
                settings: const RouteSettings(name: '/scheduleInput'),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => _buildMySchedule(),
                settings: const RouteSettings(name: '/'),
              );
          }
        },
      ),
    );
  }

  Widget _buildMySchedule() {
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
            padding: EdgeInsets.only(top: 60.h, right: 24.w, left: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Jadwal",
                      style: blackTextStyle.copyWith(
                          fontSize: 24.sp, fontWeight: bold),
                    ),
                    Row(
                      children: [
                        ChildProfileSelector(
                          onProfileChanged: (profile) async {
                            await SessionHelper().saveChildProfile(profile);

                            setState(() {
                              childName = profile.name ?? "";
                              selectedProfile = profile;
                            });
                            final dates = getFormattedDateStartAndEnd();

                            context.read<ScheduleBloc>().add(GetScheduleList(
                                  childrenId: profile.userId,
                                  dateStart: dates['dateStart']!,
                                  dateEnd: dates['dateEnd']!,
                                ));
                          },
                        ),
                        SizedBox(width: 14.w),
                        MoreOptionsDropdown(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 60.h),
                Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: softGrayColor,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentWeekIndex--;
                            });

                            final dates = getFormattedDateStartAndEnd();
                            if (selectedProfile != null) {
                              context.read<ScheduleBloc>().add(
                                    GetScheduleList(
                                      childrenId: selectedProfile!.userId,
                                      dateStart: dates['dateStart']!,
                                      dateEnd: dates['dateEnd']!,
                                    ),
                                  );
                            }
                          },
                          child: Center(
                            child: Image.asset(
                              'assets/decrement_icon.png',
                              width: 32.w,
                              height: 32.h,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(24.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            "${getFormattedDateStartAndEnd()['dateStartDisplay']} - ${getFormattedDateStartAndEnd()['dateEndDisplay']}",
                            style: blackTextStyle.copyWith(
                                fontSize: 16.sp, fontWeight: medium),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              currentWeekIndex++;
                            });

                            final dates = getFormattedDateStartAndEnd();
                            if (selectedProfile != null) {
                              context.read<ScheduleBloc>().add(
                                    GetScheduleList(
                                      childrenId: selectedProfile!.userId,
                                      dateStart: dates['dateStart']!,
                                      dateEnd: dates['dateEnd']!,
                                    ),
                                  );
                            }
                          },
                          child: Center(
                            child: Image.asset(
                              'assets/increment_icon.png',
                              width: 32.w,
                              height: 32.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                BlocBuilder<ScheduleBloc, ScheduleState>(
                  builder: (context, state) {
                    if (state is ScheduleListSuccess) {
                      final startOfWeek = getStartOfWeekForCurrentIndex();
                      clearActivityGrid();
                      populateActivities(
                          state.scheduleListResponse.data.data, startOfWeek);
                    }

                    return Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(width: 50.w),
                                ...weekDays.map((day) => Container(
                                      width: 80.w,
                                      alignment: Alignment.center,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: Text(
                                        day,
                                        style: blackTextStyle.copyWith(
                                            fontSize: 14.sp, fontWeight: bold),
                                      ),
                                    )),
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(width: 50.w),
                                ...List.generate(7, (index) {
                                  DateTime date = startOfWeek.add(Duration(
                                      days: currentWeekIndex * 7 + index));
                                  return Container(
                                    width: 80.w,
                                    alignment: Alignment.center,
                                    padding:
                                        EdgeInsets.symmetric(vertical: 4.h),
                                    child: Text(
                                      '${date.day}',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 14.sp, fontWeight: medium),
                                    ),
                                  );
                                }),
                              ],
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: List.generate(24, (hour) {
                                    return Row(
                                      children: [
                                        Container(
                                          width: 50.w,
                                          height: 60.h,
                                          alignment: Alignment.center,
                                          child: Text(
                                            '${hour.toString().padLeft(2, '0')}:00',
                                            style: blackTextStyle.copyWith(
                                                fontSize: 12.sp),
                                          ),
                                        ),
                                        ...List.generate(7, (day) {
                                          return GestureDetector(
                                            onTap: () {
                                              final data =
                                                  activityGrid[hour][day];

                                              ScheduleDetailDialog.show(
                                                  context: context,
                                                  title: data?.customName ?? "",
                                                  timeRange:
                                                      buildSimpleTimeRange(
                                                          data?.date ?? '',
                                                          data?.timeStart ?? "",
                                                          data?.timeEnd ?? ""),
                                                  repeatText: "",
                                                  note: data?.notes ?? "",
                                                  lastUpdate: formatLastUpdate(
                                                      data?.updatedAt ?? "",
                                                      childName),
                                                  scheduleId: data!.id,
                                                  schedule: data);
                                            },
                                            child: Container(
                                              width: 80.w,
                                              height: 60.h,
                                              margin: EdgeInsets.all(2.w),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(
                                                    color:
                                                        Colors.grey.shade300),
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                              alignment: Alignment.center,
                                              child: Text(
                                                activityGrid[hour][day]
                                                        ?.customName ??
                                                    "",
                                                style: blackTextStyle.copyWith(
                                                    fontSize: 10.sp,
                                                    fontWeight: bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          );
                                        }),
                                      ],
                                    );
                                  }),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 160.w,
                      height: 55.h,
                      child: OutlinedButton(
                        onPressed: () {
                          _navigatorKey.currentState!
                              .pushNamed('/scheduleInput');
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          'Input Manual',
                          style: blackTextStyle.copyWith(
                              fontSize: 18.sp, fontWeight: bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160.w,
                      height: 55.h,
                      child: OutlinedButton(
                        onPressed: () {
                          _navigatorKey.currentState!
                              .pushNamed('/findActivity');
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          'Cari Aktivitas',
                          style: blackTextStyle.copyWith(
                              fontSize: 18.sp, fontWeight: bold),
                        ),
                      ),
                    ),
                  ],
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
}
