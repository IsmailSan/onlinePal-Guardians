import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/widgets/custom_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  bool _isLoginPressed = false;
  final userNameController = TextEditingController(text: '');
  final oneTimePasswordController = TextEditingController(text: '');
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Positioned.fill(
                child: SvgPicture.asset(
                  'assets/main_login_bg.svg',
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 24, left: 24, top: 10, bottom: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.arrow_back_ios, size: 18.0),
                              SizedBox(width: 4.w),
                              Text(
                                'KEMBALI',
                                style: blackTextStyle.copyWith(
                                    fontSize: 20.sp, fontWeight: regular),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          Center(
                            child: Column(
                              children: [
                                Text(
                                  'KELUAR DARI SISTEM',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 27.sp, fontWeight: regular),
                                ),
                                Text(
                                  'ONLINEPAL FOR KIDS',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 27.sp, fontWeight: regular),
                                ),
                                SizedBox(height: 10.h),
                                Image.asset(
                                  'assets/logo_onlinePal_kids.png',
                                  width: 200.w,
                                  height: 144.h,
                                ),
                                SizedBox(height: 10.h),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          CustomFormField(
                            label: 'USERNAME',
                            hintText: '',
                            controller: userNameController,
                            focusNode: usernameFocusNode,
                            readOnly: true,
                          ),
                          SizedBox(height: 20.h),
                          CustomFormField(
                            label: 'NAMA',
                            hintText: '',
                            controller: oneTimePasswordController,
                            focusNode: passwordFocusNode,
                            readOnly: true,
                          ),
                          SizedBox(height: 20.h),
                          CustomFormField(
                            label: 'PASSWORD',
                            hintText: '',
                            controller: oneTimePasswordController,
                            focusNode: passwordFocusNode,
                          ),
                          SizedBox(height: 20.h),
                          GestureDetector(
                            onTapDown: (_) {
                              setState(() {
                                _isLoginPressed = true;
                              });
                            },
                            onTapUp: (_) {
                              setState(() {
                                _isLoginPressed = false;
                              });
                            },
                            onTapCancel: () {
                              setState(() {
                                _isLoginPressed = false;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              curve: Curves.easeOut,
                              transform: Matrix4.identity()
                                ..scale(_isLoginPressed ? 0.98 : 1.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Image.asset(
                                    'assets/red_btn.png',
                                    fit: BoxFit.cover,
                                  ),
                                  Text(
                                    'Keluar',
                                    textAlign: TextAlign.center,
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 20.sp, fontWeight: semiBold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "Aksi ini akan menonaktifan progres misi anak dan peraturan orang tua pada perangkat ini hingga kamu masuk kembali.",
                            textAlign: TextAlign.center,
                            style: blackTextStyle.copyWith(
                                fontSize: 14.sp, fontWeight: regular),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/main_bottom.png',
                      fit: BoxFit.cover,
                      height: 110.h,
                      width: 500.w,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
