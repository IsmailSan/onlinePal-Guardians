import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/profile/child_profile_screen.dart';
import 'package:online_pal_guardians/ui/screens/profile/guardian_profile_screen.dart';
import 'package:online_pal_guardians/ui/screens/profile/preference_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final tabs = ['Profil Saya', 'Anak', 'Preferensi'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
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
                      "Profil dan Preferensi",
                      style: blackTextStyle.copyWith(
                          fontSize: 20.sp, fontWeight: bold, fontStyle: italic),
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
                TabBar(
                  controller: _tabController,
                  indicatorPadding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  unselectedLabelStyle: TextStyle(fontSize: 14.sp),
                  tabs: tabs.map((title) => Tab(text: title)).toList(),
                  isScrollable: false,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      GuardianProfileScreen(isUpdateProfile: true),
                      ChildProfileScreen(isUpdateProfile: true),
                      PreferenceScreen(
                        isUpdateProfile: true,
                      )
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
}
