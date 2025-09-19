import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class LoadingDialog extends StatelessWidget {
  final String message;
  final VoidCallback? onCancel;

  const LoadingDialog({
    Key? key,
    this.message = 'Mohon Tunggu',
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 220.w,
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        decoration: BoxDecoration(
          gradient:  LinearGradient(
            colors: [softBlueColor, purpleColor],
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
              message,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: bold,
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 30.w,
              width: 30.w,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(blackColor),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
