import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/home_bloc/logout_bloc/logout_bloc.dart';
import 'package:online_pal_guardians/bloc/home_bloc/logout_bloc/logout_event.dart';
import 'package:online_pal_guardians/bloc/home_bloc/logout_bloc/logout_state.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/login/login_screen.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

Future<void> showLogoutConfirmationDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return BlocProvider.value(
        value: context.read<LogoutBloc>(),
        child: AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            "Apakah Anda yakin ingin keluar?",
            style: blackTextStyle.copyWith(fontSize: 16.sp),
          ),
          actionsPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: BlocConsumer<LogoutBloc, LogoutState>(
                    listener: (context, state) {
                      if (state is LogoutSuccess) {
                        Navigator.of(context).pop();
                        SessionHelper().clearAllPreferences();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const LoginScreen()),
                          (route) => false,
                        );
                      } else if (state is LogoutError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                            (route) => false,
                          );
                          SessionHelper().clearAllPreferences();
                          context
                              .read<LogoutBloc>()
                              .add(const LogoutButtonPressed());
                        },
                        child: Text("Iya",
                            style: redTextStyle.copyWith(fontSize: 14.sp)),
                      );
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Tidak",
                        style: blackTextStyle.copyWith(fontSize: 14.sp)),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    },
  );
}
