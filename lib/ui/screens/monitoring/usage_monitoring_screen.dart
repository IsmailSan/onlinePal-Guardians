import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:online_pal_guardians/bloc/monitoring_bloc/monitoring_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_event.dart';
import 'package:online_pal_guardians/models/monitoring/screen_activity_response.dart';
import 'package:online_pal_guardians/models/monitoring/screen_time_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/weekly_report_screen.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/widgets/app_usage_progress_row.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/widgets/day_date_labels.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/widgets/screen_time_bar_chart.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class UsageMonitoringScreen extends StatefulWidget {
  const UsageMonitoringScreen({Key? key}) : super(key: key);

  @override
  State<UsageMonitoringScreen> createState() => _UsageMonitoringScreenState();

  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget page;
        if (settings.name == '/weeklyReport') {
          page = const WeeklyReportScreen();
        } else {
          page = const UsageMonitoringScreen();
        }
        return MaterialPageRoute(builder: (context) => page);
      },
    );
  }
}

class _UsageMonitoringScreenState extends State<UsageMonitoringScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final profile = await SessionHelper().getChildProfile();
      final childUserId = profile?.userId;
      context.read<ChildProfileBloc>().add(GetChildrenProfile());
      context.read<MonitoringBloc>().add(GetMonitoringCombined("$childUserId"));
    });
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
            case '/weeklyReport':
              return MaterialPageRoute(
                builder: (_) => const WeeklyReportScreen(),
                settings: const RouteSettings(name: '/weeklyReport'),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => _buildUsageMonitoring(),
                settings: const RouteSettings(name: '/'),
              );
          }
        },
      ),
    );
  }

  Widget _buildUsageMonitoring() {
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
                      "Monitoring Penggunaan",
                      style: blackTextStyle.copyWith(
                          fontSize: 20.sp, fontWeight: bold, fontStyle: italic),
                    ),
                    Row(
                      children: [
                        ChildProfileSelector(
                          onProfileChanged: (profile) {
                            context
                                .read<MonitoringBloc>()
                                .add(MonitoringEventInitialized());
                            context.read<MonitoringBloc>().add(
                                GetMonitoringCombined("${profile.userId}"));
                          },
                        ),
                        SizedBox(width: 14.w),
                        MoreOptionsDropdown(),
                      ],
                    ),
                  ],
                ),
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
                SizedBox(height: 37.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: BlocConsumer<MonitoringBloc, MonitoringState>(
                        listener: (context, state) {
                      if (state is MonitoringError) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => ErrorDialog(message: state.message),
                        );
                      }
                    }, builder: (context, state) {
                      List<ScreenTimeItem> screenTimeList = [];
                      List<ScreenActivityItem> screenActivityList = [];
                      if (state is GetMonitoringCombinedSuccess) {
                        screenTimeList = state.screenTime.data?.data ?? [];
                        screenActivityList =
                            state.screenActivity.data?.screenActivity ?? [];
                      }
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: MenuItem(
                            //     width: 100.w,
                            //     assetPath: 'assets/weekly_report_btn.png',
                            //     onTap: () {
                            //       _navigatorKey.currentState!
                            //           .pushNamed('/weeklyReport');
                            //     },
                            //   ),
                            // ),
                            SizedBox(height: 16.h),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    'Screen Time',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 20.sp, fontWeight: bold),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    '(7 hari terakhir)',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 12.sp, fontWeight: bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),

                            if (screenTimeList.isEmpty)
                              Column(
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
                                    'Screen time tidak tersedia',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 16.sp, fontWeight: bold),
                                  ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  DayDateLabels(
                                    days: screenTimeList
                                        .map((day) => day.date != null
                                            ? DateFormat('E').format(
                                                DateTime.parse(day.date!))
                                            : '')
                                        .toList(),
                                    dates: screenTimeList
                                        .map((date) => date.date != null
                                            ? DateTime.parse(date.date!)
                                                .day
                                                .toString()
                                            : '')
                                        .toList(),
                                  ),
                                  const SizedBox(height: 12),
                                  ScreenTimeBarChart(
                                    title: '',
                                    data: screenTimeList
                                        .map((time) =>
                                            double.tryParse(
                                                time.totalScreenTime ?? '0') ??
                                            0.0)
                                        .toList(),
                                    barColor: lightBlueColor,
                                  ),
                                ],
                              ),

                            SizedBox(height: 36.h),

                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Aktivitas Layar',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 20.sp, fontWeight: bold),
                                  ),
                                  SizedBox(height: 17.h),
                                  Text(
                                    'berdasarkan aplikasi',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 16.sp, fontWeight: bold),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.h),
                            if (screenActivityList.isEmpty)
                              Column(
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
                                    'Aktivitas layar tidak tersedia',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 16.sp, fontWeight: bold),
                                  ),
                                ],
                              )
                            else
                              Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 120),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            'hari ini',
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'rata-rata\n7 hari',
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            'rata-rata\n30 hari',
                                            style: TextStyle(fontSize: 12),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 8.h),

                                  // 🔹 Loop list dari API
                                  ...screenActivityList.map((activity) {
                                    final today = activity.averageToday ?? 0;
                                    final avg7 = activity.averageLast7Days ?? 0;
                                    final avg30 =
                                        activity.averageLast30Days ?? 0;

                                    return AppUsageProgressRow(
                                      title: activity.nameApps ?? '-',
                                      progressValues: [
                                        today / 60,
                                        avg7 / 60,
                                        avg30 / 60
                                      ],
                                      timeLabels: [
                                        '${today} min',
                                        '${avg7} min',
                                        '${avg30} min'
                                      ],
                                    );
                                  }).toList()
                                ],
                              ),

                            SizedBox(height: 8.h),

                            const SizedBox(height: 30),
                            // SizedBox(height: 36.h),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: [
                            //       Text(
                            //         'Progress Misi',
                            //         style: blackTextStyle.copyWith(
                            //             fontSize: 20.sp, fontWeight: bold),
                            //       ),
                            //       SizedBox(width: 8.w),
                            //       Text(
                            //         '(7 hari terakhir)',
                            //         style: blackTextStyle.copyWith(
                            //             fontSize: 12.sp, fontWeight: bold),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(height: 20.h),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 130),
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         child: Text(
                            //           '  % Berhasil',
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 11.sp, fontWeight: regular),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Text(
                            //           '  Akumulasi Poin',
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 11.sp, fontWeight: regular),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Text(
                            //           'Hadiah',
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 11.sp, fontWeight: regular),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Text(
                            //           'Hukuman',
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 11.sp, fontWeight: regular),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // FlexibleInfoRow(
                            //   cells: const [
                            //     Text(
                            //       '1. Tidak bermain game\nonline di hari sekolah.',
                            //       style: TextStyle(
                            //           fontSize: 12, fontWeight: FontWeight.w400),
                            //     ),
                            //     Text(
                            //       '40%',
                            //       style:
                            //           TextStyle(fontSize: 12, color: Colors.red),
                            //     ),
                            //     Text(
                            //       '-90',
                            //       style:
                            //           TextStyle(fontSize: 12, color: Colors.red),
                            //     ),
                            //     Text(
                            //       '-',
                            //       style:
                            //           TextStyle(fontSize: 12, color: Colors.red),
                            //     ),
                            //     Text(
                            //       '3x',
                            //       style:
                            //           TextStyle(fontSize: 12, color: Colors.red),
                            //     ),
                            //   ],
                            //   textWidths: const [130, 30, 30, 30, 30],
                            //   underlineColor: Colors.grey[300],
                            // ),
                            // SizedBox(height: 36.h),
                            // Align(
                            //   alignment: Alignment.centerLeft,
                            //   child: Row(
                            //     crossAxisAlignment: CrossAxisAlignment.end,
                            //     children: [
                            //       Text(
                            //         'Poin',
                            //         style: blackTextStyle.copyWith(
                            //             fontSize: 20.sp, fontWeight: bold),
                            //       ),
                            //       SizedBox(width: 8.w),
                            //       Text(
                            //         '(7 hari terakhir)',
                            //         style: blackTextStyle.copyWith(
                            //             fontSize: 12.sp, fontWeight: bold),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(height: 20.h),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 200),
                            //   child: Row(
                            //     children: [
                            //       Expanded(
                            //         child: Text(
                            //           'Perubahan Poin',
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 11.sp, fontWeight: regular),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //       Expanded(
                            //         child: Text(
                            //           'Akumulasi Poin',
                            //           style: blackTextStyle.copyWith(
                            //               fontSize: 11.sp, fontWeight: regular),
                            //           textAlign: TextAlign.center,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // FlexibleInfoRow(
                            //   cells: const [
                            //     Text(
                            //       '28/12',
                            //       style: TextStyle(
                            //           fontSize: 12, fontWeight: FontWeight.bold),
                            //     ),
                            //     Column(
                            //       crossAxisAlignment: CrossAxisAlignment.start,
                            //       children: [
                            //         Text(
                            //           'Misi Berhasil',
                            //           style: TextStyle(
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //         Text(
                            //           'Membuat jadwal mingguan',
                            //           style: TextStyle(
                            //             fontSize: 11,
                            //             fontStyle: FontStyle.italic,
                            //             color: Colors.grey,
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //     Text(
                            //       '+80',
                            //       style: TextStyle(
                            //           fontSize: 12, color: Colors.green),
                            //     ),
                            //     Text(
                            //       '+280',
                            //       style: TextStyle(
                            //           fontSize: 12, color: Colors.green),
                            //     ),
                            //   ],
                            //   textWidths: const [50, 140, 50, 50],
                            //   underlineColor: Colors.grey[300],
                            // ),
                            // SizedBox(height: 100.h),
                          ]);
                    }),
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<MonitoringBloc, MonitoringState>(
            builder: (context, state) {
              if (state is MonitoringLoading) {
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
