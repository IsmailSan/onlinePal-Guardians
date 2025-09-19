import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_event.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/profile/child_profile_screen.dart';
import 'package:online_pal_guardians/ui/screens/profile/update_profile_screen.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          // Background Wave
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

          // Main Content
          Padding(
            padding: EdgeInsets.only(left: 21.w, right: 21.w, top: 60.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pengaturan Aplikasi",
                      style: blackTextStyle.copyWith(
                        fontSize: 20.sp,
                        fontWeight: bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Row(
                      children: [
                        ChildProfileSelector(),
                        SizedBox(width: 14.w),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: 60.h),

                // Kembali Row
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
                          fontSize: 16.sp,
                          fontWeight: bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 37.h),

                Column(
                  children: [
                    _SettingsItem(
                      svgIconPath: 'assets/setting_profile_icon.svg',
                      label: 'Profil',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const UpdateProfileScreen()));
                      },
                    ),
                    _SettingsItem(
                      svgIconPath: 'assets/add_child_profile_icon.svg',
                      label: 'Tambah Profil Anak',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ChildProfileScreen()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsItem extends StatelessWidget {
  final String svgIconPath;
  final String label;
  final VoidCallback onTap;

  const _SettingsItem({
    required this.svgIconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 4.w),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgIconPath,
              height: 40.h,
              width: 40.w,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                label,
                style: blackTextStyle.copyWith(
                  fontSize: 16.sp,
                  fontWeight: medium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
