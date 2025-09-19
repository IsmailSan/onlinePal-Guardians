import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/avatar/avatar_collection_screen.dart';
import 'package:online_pal_guardians/ui/screens/profile/child_profile_screen.dart';
import 'package:online_pal_guardians/ui/screens/profile/guardian_profile_screen.dart';
import 'package:online_pal_guardians/ui/screens/profile/preference_screen.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({Key? key}) : super(key: key);

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen>
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
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.only(right: 21, left: 21),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/mini_logo.png',
                          height: 30.h,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.arrow_back_ios, size: 18.0),
                              SizedBox(width: 4.w),
                              Text(
                                'KEMBALI',
                                style: blackTextStyle.copyWith(
                                    fontSize: 17.sp, fontWeight: regular),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () async {
                            final session = SessionHelper();
                            final isGuardianDone = await session.isGuardianProfileFilled();
                            final isChildDone = await session.isChildProfileFilled();
                            final isPrefDone = await session.isPreferenceProfileFilled();

                            if (isGuardianDone && isChildDone && isPrefDone) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AvatarCollectionScreen()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Mohon lengkapi semua bagian profil terlebih dahulu.'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Lanjut',
                                style: blackTextStyle.copyWith(
                                    fontSize: 17.sp, fontWeight: regular),
                              ),
                              SizedBox(width: 4.w),
                              const Icon(Icons.arrow_forward_ios, size: 18.0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    "Profil dan Preferensi",

                    style: blackTextStyle.copyWith(
                        fontSize: 16.sp, fontWeight: bold,),
                  ),
                ),
                SizedBox(height: 30.h),
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
                      GuardianProfileScreen(),
                      ChildProfileScreen(isRegistration: true,),
                      PreferenceScreen()
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
