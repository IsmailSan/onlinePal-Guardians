import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class ConfirmActionDialog<T extends Bloc> extends StatelessWidget {
  final String title;
  final String subtitle;
  final String primaryButtonText;
  final String secondaryButtonText;
  final Color primaryButtonColor;
  final Color secondaryButtonColor;
  final Color primaryButtonTextColor;
  final dynamic onConfirmEvent;

  const ConfirmActionDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.primaryButtonColor,
    required this.secondaryButtonColor,
    required this.onConfirmEvent,
    this.primaryButtonTextColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [lightBlueColor, purpleColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: blackColor, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontSize: 16.sp, fontWeight: bold),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () {
                      context.read<T>().add(onConfirmEvent);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      primaryButtonText,
                      style: whiteTextStyle.copyWith(fontSize: 14.sp,    color: primaryButtonTextColor,),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: secondaryButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      secondaryButtonText,
                      style: grayTextStyle.copyWith(fontSize: 14.sp),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(fontSize: 14.sp, fontWeight: semiBold, fontStyle: italic),
            ),
          ],
        ),
      ),
    );
  }
}

