import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_event.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/widgets/app_usage_progress_row.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/widgets/day_date_labels.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/widgets/flexible_info_row.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/widgets/screen_time_bar_chart.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';

class WeeklyReportDetailScreen extends StatefulWidget {
  const WeeklyReportDetailScreen({Key? key}) : super(key: key);

  @override
  State<WeeklyReportDetailScreen> createState() =>
      _WeeklyReportDetailScreenState();
}

class _WeeklyReportDetailScreenState extends State<WeeklyReportDetailScreen> {
  ChildProfile? selectedProfile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChildProfileBloc>().add(GetChildrenProfile());
    });
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
                      "Monitoring Penggunaan",
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
                SizedBox(height: 37.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 36.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Screen Time & Aktivitas Online',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 20.sp, fontWeight: bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          const DayDateLabels(
                            days: [
                              'Mon',
                              'Tue',
                              'Wed',
                              'Thu',
                              'Fri',
                              'Sat',
                              'Sun'
                            ],
                            dates: ['22', '23', '24', '25', '26', '27', '28'],
                          ),
                          const SizedBox(height: 12),
                          ScreenTimeBarChart(
                            title: 'HP Brandon',
                            data: const [37, 82, 0, 57, 40, 55, 112],
                            barColor: lightBlueColor,
                          ),
                          const SizedBox(height: 12),
                          ScreenTimeBarChart(
                            title: 'Tablet Brandon',
                            data: const [37, 82, 0, 57, 40, 55, 112],
                            barColor: lightBlueColor,
                          ),
                          const SizedBox(height: 12),
                          ScreenTimeBarChart(
                            title: 'Total Screen Time',
                            data: const [37, 82, 0, 57, 40, 55, 112],
                            barColor: purpleColor,
                          ),
                          SizedBox(height: 36.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Aktivitas Layar Brandon',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 20.sp, fontWeight: bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
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
                          AppUsageProgressRow(
                            title: 'Mobile Legends',
                            progressValues: const [0.1, 0.5, 0.7],
                            timeLabels: const ['55 min', '45 min', '52 min'],
                          ),
                          SizedBox(height: 8.h),
                          AppUsageProgressRow(
                            title: 'Youtube',
                            progressValues: const [0.1, 0.5, 0.7],
                            timeLabels: const ['55 min', '45 min', '52 min'],
                          ),
                          SizedBox(height: 8.h),
                          AppUsageProgressRow(
                            title: 'Google Chrome',
                            progressValues: const [0.1, 0.5, 0.7],
                            timeLabels: const ['55 min', '45 min', '52 min'],
                          ),
                          SizedBox(height: 8.h),
                          AppUsageProgressRow(
                            title: 'Duolinggo',
                            progressValues: const [0.1, 0.5, 0.7],
                            timeLabels: const ['55 min', '45 min', '52 min'],
                          ),
                          SizedBox(height: 36.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Progress Misi',
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
                          SizedBox(height: 20.h),
                          Padding(
                            padding: const EdgeInsets.only(left: 130),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '  % Berhasil',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 11.sp, fontWeight: regular),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    '  Akumulasi Poin',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 11.sp, fontWeight: regular),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Hadiah',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 11.sp, fontWeight: regular),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Hukuman',
                                    style: blackTextStyle.copyWith(
                                        fontSize: 11.sp, fontWeight: regular),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          FlexibleInfoRow(
                            cells: const [
                              Text(
                                '1. Tidak bermain game\nonline di hari sekolah.',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w400),
                              ),
                              Text(
                                '40%',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              ),
                              Text(
                                '-90',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              ),
                              Text(
                                '-',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              ),
                              Text(
                                '3x',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.red),
                              ),
                            ],
                            textWidths: const [130, 30, 30, 30, 30],
                            underlineColor: Colors.grey[300],
                          ),
                          SizedBox(height: 36.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Rekomendasi untuk Orang tua',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 20.sp, fontWeight: bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 12.h),
                              ...List.generate(2, (index) {
                                final titles = [
                                  "Mendorong anak untuk melakukan banyak aktivitas online yang positif.",
                                  "Jika memungkinkan, tetapkan hari tertentu dalam seminggu sebagai hari tanpa gadget.",
                                ];

                                final descriptions = [
                                  "Anak Anda menghabiskan terlalu banyak waktu bermain game online. "
                                      "Anda dapat membuat misi untuk mendorongnya menggunakan internet untuk hal-hal positif, seperti belajar, "
                                      "melakukan hobi yang positif, atau kegiatan keagamaan. Terlalu banyak bermain game dapat menyebabkan kecanduan dan penurunan prestasi akademis.",
                                  "Seimbangkan aktivitas anak Anda dengan aktivitas di dunia nyata, "
                                      "dan tetapkan hari tertentu dalam seminggu sebagai hari tanpa layar untuk menghindari ketergantungan pada gadget dan internet.",
                                ];

                                return Padding(
                                  padding: EdgeInsets.only(bottom: 12.h),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              titles[index],
                                              style: blackTextStyle.copyWith(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              descriptions[index],
                                              style: blackTextStyle.copyWith(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w300,
                                                fontStyle: FontStyle.italic,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                          SizedBox(height: 100.h),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
