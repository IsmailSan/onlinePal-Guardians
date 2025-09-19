import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  final VoidCallback? onOk;

  const ErrorDialog({
    Key? key,
    required this.message,
    this.onOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260.w,
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
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
            Icon(Icons.error_outline, size: 40.w, color: Colors.red),
            SizedBox(height: 12.h),
            Text(
              'Terjadi Kesalahan',
              style: blackTextStyle.copyWith(fontSize: 16.sp, fontWeight: bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              style: blackTextStyle.copyWith(fontSize: 14.sp, fontWeight: bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: blackColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                if (onOk != null) onOk!();
              },
              child: Text(
                'OK',
                style: whiteTextStyle.copyWith(fontSize: 16.sp, fontWeight: bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
