import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/settings/settings_screen.dart';
import 'package:online_pal_guardians/ui/widgets/logout_confirmation_dialog.dart';

class MoreOptionsDropdown extends StatelessWidget {
  const MoreOptionsDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;

        showMenu<String>(
          context: context,
          position: RelativeRect.fromRect(
            details.globalPosition & const Size(40, 40),
            Offset.zero & overlay.size,
          ),
          color: Colors.transparent,
          elevation: 0,
          items: [
            PopupMenuItem<String>(
              enabled: false,
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                  color: lightBlueColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border:
                      Border.all(color: grayColor.withOpacity(0.5), width: 0.5),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, 'settings');
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        child: Text(
                          "Pengaturan Aplikasi",
                          style: blackTextStyle.copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ),
                    Divider(height: 1, thickness: 0.5, color: grayColor),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context, 'logout');
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        child: Text(
                          "Logout",
                          style: redTextStyle.copyWith(fontSize: 12.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).then((value) {
          if (value == 'settings') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          } else if (value == 'logout') {
            showLogoutConfirmationDialog(context);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: const BoxDecoration(
          color: Colors.indigo,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.more_horiz, size: 18.0, color: Colors.white),
      ),
    );
  }
}
