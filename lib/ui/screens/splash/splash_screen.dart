import 'dart:async';
import 'package:flutter/material.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/main_screen.dart';
import 'package:online_pal_guardians/ui/screens/welcome_page.dart';
import 'package:online_pal_guardians/utils/globals.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final token = await SessionHelper().getToken();
print("tokennya ${token}");
    await Future.delayed(const Duration(seconds: 3));

    if (token != null && token.isNotEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => MainScreen(key: mainScreenKey),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo_onlinepal_guardians.png",
                width: 200.w,
                height: 200.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
