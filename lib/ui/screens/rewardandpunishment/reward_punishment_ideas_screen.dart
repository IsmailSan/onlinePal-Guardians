import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_event.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/dialog/search_filter_dialog.dart';
import 'package:online_pal_guardians/ui/screens/schedule/schedule_input_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/utils/text_utils.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';

class RewardPunishmentIdeasScreen extends StatefulWidget {
  const RewardPunishmentIdeasScreen({Key? key}) : super(key: key);

  @override
  State<RewardPunishmentIdeasScreen> createState() => _RewardPunishmentIdeasScreenState();
}

class _RewardPunishmentIdeasScreenState extends State<RewardPunishmentIdeasScreen> {
  final List<Map<String, dynamic>> activities = [
    {
      "title": "Menonton Film Bersama Orang tua malam ini",
      "category": "Bentuk: Aktivitas; Kategori: Acara Keluarga",
      "price": "Estimasi biaya: Gratis",
    },
    {
      "title": "Pergi ke mall bersama orang tua akhir pekan",
      "category": "Bentuk: Aktivitas; Kategori: Acara Keluarga",
      "price": "Estimasi biaya: Rp.100.000",
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
                      "Hadiah",
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
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const SearchFilterDialog();
                            },
                          );
                        },
                        child: SvgPicture.asset(
                          'assets/filter_icon.svg',
                          width: 24.w,
                          height: 24.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ListView.builder(
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        return _buildIdeaItem(
                            activities[index], index + 1);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIdeaItem(Map<String, dynamic> activity, int index) {
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
                        activity["title"],
                        style: blackTextStyle.copyWith(
                            fontSize: 15.sp, fontWeight: medium),
                        overflow: TextOverflow.visible,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        truncateText(activity["category"], 32),
                        style: grayTextStyle.copyWith(
                            fontSize: 10.sp, fontWeight: regular, fontStyle: italic),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        truncateText(activity["price"], 32),
                        style: grayTextStyle.copyWith(
                            fontSize: 10.sp, fontWeight: regular, fontStyle: italic),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 55.h,
                  width: 90.w,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ScheduleInputScreen()));
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
