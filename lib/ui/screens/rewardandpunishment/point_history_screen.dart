import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_event.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/dialog/search_filter_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/ui/widgets/point_bar_chart.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';

class PointHistoryScreen extends StatefulWidget {
  const PointHistoryScreen({Key? key}) : super(key: key);

  @override
  State<PointHistoryScreen> createState() => _PointHistoryScreenState();
}

DateTime getStartOfWeek(DateTime date) {
  int diff = date.weekday - DateTime.monday;
  return date.subtract(Duration(days: diff));
}

List<String> getIndonesianWeekLabels(DateTime startOfWeek) {
  const dayNames = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
  return List.generate(7, (i) {
    final date = startOfWeek.add(Duration(days: i));
    return '${dayNames[i]}\n${date.day}';
  });
}

List<String> getIndonesianMonthLabels(DateTime startMonth) {
  const monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
    'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
  ];

  return List.generate(7, (i) {
    final date = DateTime(startMonth.year, startMonth.month + i);
    return '${monthNames[date.month - 1]}\n${date.year}';
  });
}

class _PointHistoryScreenState extends State<PointHistoryScreen> {
  ChildProfile? selectedProfile;
  final List<Map<String, dynamic>> rewardList = [
    {
      "title":
      "Bermain sepak bola pulang sekolah selama satu minggu berturut-turut.",
      "periode": "10/04/2024 - 17/04/2024",
      "point": "20 Poin",
    },
    {
      "title": "Aku boleh memilih menu makan sendiri selama seminggu penuh",
      "periode": "01/04/2024 - 07/04/2024",
      "point": "10 Poin",
    },
    {
      "title": "Hadiah kejutan dari orang tuamu",
      "periode": "03/04/2024 - 11/04/2024",
      "point": "15 Poin",
    },
    {
      "title": "Main ke taman bermain bersama keluarga",
      "periode": "15/04/2024 - 20/04/2024",
      "point": "25 Poin",
    },
  ];
  DateTime currentStartDate = getStartOfWeek(DateTime.now());
  DateTime currentMonthStart = DateTime(DateTime.now().year, DateTime.now().month);
  String selectedOption = 'Harian';

  void _goToNext() {
    setState(() {
      if (selectedOption == 'Harian') {
        currentStartDate = currentStartDate.add(const Duration(days: 7));
      } else {
        currentMonthStart = DateTime(currentMonthStart.year, currentMonthStart.month + 1);
      }
    });
  }

  void _goToPrevious() {
    setState(() {
      if (selectedOption == 'Harian') {
        currentStartDate = currentStartDate.subtract(const Duration(days: 7));
      } else {
        currentMonthStart = DateTime(currentMonthStart.year, currentMonthStart.month - 1);
      }
    });
  }

  final List<Map<String, dynamic>> historyItems = [
    {
      'date': '28/12',
      'title': 'Misi Berhasil',
      'subtitle': 'Membuat jadwal mingguan',
      'point': 60,
      'accumulated': 250,
    },
    {
      'date': '28/12',
      'title': 'Misi Berhasil',
      'subtitle': 'Tidak menggunakan gadget selama...',
      'point': 50,
      'accumulated': 200,
    },
    {
      'date': '27/12',
      'title': 'Reduksi Poin',
      'subtitle': 'Bermain games selama hari biasa',
      'point': -50,
      'accumulated': 150,
    },
  ];

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
                      "Riwayat Poin",
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_back_ios, size: 18.0, color: Colors.black),
                          SizedBox(width: 4.w),
                          Text(
                            'Kembali',
                            style: blackTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
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
                                  hintText: "Cari",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => const SearchFilterDialog(),
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/filter_icon.svg',
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Expanded(child:   SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Akumulasi Poin',
                            style: blackTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedOption,
                                isDense: true,
                                icon: const Icon(Icons.arrow_drop_down, size: 18),
                                style: blackTextStyle.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                                items: ['Harian', 'Bulanan'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Column(children: [
                        Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10, left: 10),
                                    child: GestureDetector(
                                      onTap: _goToPrevious,
                                      child: SvgPicture.asset(
                                        'assets/arrow_triangle_left.svg',
                                        width: 30.w,
                                        height: 30.h,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 12.h),
                                        Row(
                                          children: (selectedOption == 'Harian'
                                              ? getIndonesianWeekLabels(currentStartDate)
                                              : getIndonesianMonthLabels(currentMonthStart))
                                              .map((label) => Expanded(
                                            child: Center(
                                              child: Text(
                                                label,
                                                textAlign: TextAlign.center,
                                                style: blackTextStyle.copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: extraBold,
                                                ),
                                              ),
                                            ),
                                          ))
                                              .toList(),
                                        ),
                                        const SizedBox(height: 4),
                                        const PointBarChart(
                                          data: [20, -10, 10, -5, 25, 15, 20],
                                          labels: ['20', '-10', '30', '-5', '25', '15', '20'],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10, left: 10),
                                    child: GestureDetector(
                                      onTap: _goToNext,
                                      child: Transform.rotate(
                                        angle: 3.14, // rotasi 180 derajat
                                        child: SvgPicture.asset(
                                          'assets/arrow_triangle_left.svg',
                                          width: 30.w,
                                          height: 30.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 22.h),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Perolehan Poin',
                            style: blackTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedOption,
                                isDense: true,
                                icon: const Icon(Icons.arrow_drop_down, size: 18),
                                style: blackTextStyle.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectedOption = value!;
                                  });
                                },
                                items: ['Harian', 'Bulanan'].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Column(children: [
                        Center(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10, left: 10),
                                    child: GestureDetector(
                                      onTap: _goToPrevious,
                                      child: SvgPicture.asset(
                                        'assets/arrow_triangle_left.svg',
                                        width: 30.w,
                                        height: 30.h,
                                      ),
                                    ),
                                  ),

                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 12.h),
                                        Row(
                                          children: (selectedOption == 'Harian'
                                              ? getIndonesianWeekLabels(currentStartDate)
                                              : getIndonesianMonthLabels(currentMonthStart))
                                              .map((label) => Expanded(
                                            child: Center(
                                              child: Text(
                                                label,
                                                textAlign: TextAlign.center,
                                                style: blackTextStyle.copyWith(
                                                  fontSize: 12.sp,
                                                  fontWeight: extraBold,
                                                ),
                                              ),
                                            ),
                                          ))
                                              .toList(),
                                        ),

                                        const SizedBox(height: 4),
                                        const PointBarChart(
                                          data: [20, -10, 10, -5, 25, 15, 20],
                                          labels: ['20', '-10', '30', '-5', '25', '15', '20'],
                                        ),
                                      ],
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 10, left: 10),
                                    child: GestureDetector(
                                      onTap: _goToNext,
                                      child: Transform.rotate(
                                        angle: 3.14, // rotasi 180 derajat
                                        child: SvgPicture.asset(
                                          'assets/arrow_triangle_left.svg',
                                          width: 30.w,
                                          height: 30.h,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: 22.h),
                            ],
                          ),
                        ),
                      ]),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFB1A9FF),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      
                        Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            children: [
                              const Spacer(), // push to right
                              SizedBox(
                                width: 90.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Poin', style: blackTextStyle.copyWith(fontSize: 10.sp,fontWeight: FontWeight.bold)),
                                    Text('Akumulasi', style: blackTextStyle.copyWith(fontSize: 10.sp,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: Colors.white54, thickness: 1),

                        // Log item
                        ...historyItems.map((item) {
                          final point = item['point'];
                          final accumulated = item['accumulated'];

                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Tanggal
                                    SizedBox(
                                      width: 40.w,
                                      child: Text(
                                        item['date'],
                                        style: blackTextStyle.copyWith(fontSize: 12.sp),
                                      ),
                                    ),
                                    SizedBox(width: 6.w),

                                    // Judul & subtitle
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['title'],
                                            style: blackTextStyle.copyWith(fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            item['subtitle'],
                                            style: blackTextStyle.copyWith(fontSize: 12.sp),
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Poin dan Akumulasi (Row tetap, dalam SizedBox)
                                    SizedBox(
                                      width: 90.w,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${point > 0 ? '+' : ''}$point',
                                            style: TextStyle(
                                              color: point >= 0 ? Colors.green : Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '+$accumulated',
                                            style: const TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(height: 1, color: Colors.white70),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  ],
                  ),
                ),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
