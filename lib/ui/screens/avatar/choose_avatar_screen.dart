import 'package:flutter/material.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/ui/screens/avatar/avatar_collection_screen.dart';

class ChooseAvatarScreen extends StatefulWidget {
  const ChooseAvatarScreen({Key? key}) : super(key: key);

  @override
  State<ChooseAvatarScreen> createState() => _ChooseAvatarScreenState();
}

class _ChooseAvatarScreenState extends State<ChooseAvatarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      'assets/mini_logo.png',
                                      height: 30.h,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.arrow_back_ios, size: 18.0),
                                        SizedBox(width: 4.w),
                                        Text(
                                          'KEMBALI',
                                          style: blackTextStyle.copyWith(fontSize: 17.sp, fontWeight: regular),
                                        ),
                                      ],
                                    ),
                                  ),]
                            ),
                            SizedBox(height: 35.h),
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Buat Avatar Pribadi Anda',
                                    style: blackTextStyle.copyWith(fontSize: 27.sp, fontWeight: regular),
                                  ),
                                  SizedBox(height: 20.h),
                                  Container(
                                    width: 340.w,
                                    height: 276.h,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFFD9D9D9), Color(0xFF737373)],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: Image.asset(
                                        'assets/choose_avatar.png',
                                        height: 220.h,
                                        width: 330.w,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 30.h),
                            // SizedBox(
                            //   width: double.infinity,
                            //   child: OutlinedButton(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => const ChooseAvatarScreen()));
                            //     },
                            //     style: OutlinedButton.styleFrom(
                            //       side: const BorderSide(color: Colors.black),
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(8),
                            //       ),
                            //       padding: const EdgeInsets.symmetric(vertical: 16),
                            //       backgroundColor: Colors.white,
                            //     ),
                            //     child: Text(
                            //       'Buat avatar secara manual',
                            //       style: blackTextStyle.copyWith(fontSize: 20.sp, fontWeight: bold),
                            //     ),
                            //   ),
                            // ),
                            // SizedBox(height: 25.h),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const AvatarCollectionScreen()));
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.black),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: Colors.white,
                                ),
                                child: Text(
                                  ' Pilih avatar dari koleksi aplikasi',
                                  style: blackTextStyle.copyWith(fontSize: 20.sp, fontWeight: bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/main_bottom.png',
                  fit: BoxFit.cover,
                  height: 110.h,
                  width: double.infinity,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
