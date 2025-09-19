import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_event.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/weekly_report_detail_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';

class WeeklyReportScreen extends StatefulWidget {
  const WeeklyReportScreen({Key? key}) : super(key: key);

  @override
  State<WeeklyReportScreen> createState() => _WeeklyReportScreenState();
}

class _WeeklyReportScreenState extends State<WeeklyReportScreen> {
  final List<Map<String, dynamic>> weeklyReport = [
    {
      "title": "Laporan Mingguan: 22 - 28 Des 2024",
      "subtitle": "Total Screen Time: 13.58 hours",
    },
    {
      "title": "Laporan Mingguan: 5 - 20 Des 2024",
      "subtitle": "Total Screen Time: 3.58 hours",
    },
    {
      "title": "Laporan Mingguan: 3 - 4 Des 2024",
      "subtitle": "Total Screen Time: 10.58 hours",
    },
  ];

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
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Laporan Mingguan",
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
                SizedBox(height: 60.h),
                Row(
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
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
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
                SizedBox(height: 150.h),
                // Text(
                //   'Laporan mingguan dibuat secara otomatis di akhir minggu (Setiap Senin sekitar PK 00.00)',
                //   style: blackTextStyle.copyWith(
                //       fontSize: 14.sp, fontWeight: regular),
                // ),
                // Expanded(
                //   child: ListView.builder(
                //     itemCount: weeklyReport.length,
                //     itemBuilder: (context, index) {
                //       return _buildWeeklyReportItem(weeklyReport[index]);
                //     },
                //   ),
                // ),

                Center(
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
                        'Laporan tidak tersedia',
                        style: blackTextStyle.copyWith(fontSize: 16.sp, fontWeight: bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyReportItem(Map<String, dynamic> weeklyReport) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Text(
                        weeklyReport["title"],
                        style: blackTextStyle.copyWith(
                            fontSize: 14.sp, fontWeight: regular),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        weeklyReport["subtitle"],
                        style: blackTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: extraLight,
                            fontStyle: italic),
                      ),
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
                                  const WeeklyReportDetailScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purpleColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.w)),
                    ),
                    child: Text(
                      "LIHAT",
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
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
