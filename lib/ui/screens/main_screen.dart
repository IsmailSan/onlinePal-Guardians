import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/home/home_screen.dart';
import 'package:online_pal_guardians/ui/screens/mission/child_mission_screen.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/usage_monitoring_screen.dart';
import 'package:online_pal_guardians/ui/screens/notification/notification_screen.dart';
import 'package:online_pal_guardians/ui/screens/schedule/child_schedule_screen.dart';
import 'package:online_pal_guardians/ui/widgets/logout_confirmation_dialog.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  DateTime? _lastBackPressTime;

  void _handleDoubleBackPress() {
    final now = DateTime.now();
    if (_lastBackPressTime == null || now.difference(_lastBackPressTime!) > const Duration(seconds: 2)) {
      _lastBackPressTime = now;
    } else {
      showLogoutConfirmationDialog(context);
    }
  }


  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationScreen(),
    const ChildMissionScreen(),
    const UsageMonitoringScreen(),
    const ChildScheduleScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          _handleDoubleBackPress();
        }
      },
      child: Scaffold(
        body: _screens[selectedIndex],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedLabelStyle: purpleTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.normal),
              unselectedLabelStyle: grayTextStyle.copyWith(fontSize: 12.sp, fontWeight: FontWeight.normal),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            selectedItemColor: Colors.indigo,
            unselectedItemColor: bottomNavGray,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset("assets/home_icon.png", width: 40.w, height: 40.h),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/notification_icon.png", width: 40.w, height: 40.h),
                label: "Notifikasi",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/mission_icon.png", width: 40.w, height: 40.h),
                label: "Misi",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/monitoring_icon.png", width: 40.w, height: 40.h),
                label: "Monitoring",
              ),
              BottomNavigationBarItem(
                icon: Image.asset("assets/schedule_icon.png", width: 40.w, height: 40.h),
                label: "Jadwal",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
