import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_event.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmDeleteMissionDialog extends StatelessWidget {
  final int missionId;

  const ConfirmDeleteMissionDialog({
    super.key,
    required this.missionId,
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
              'Apakah Anda yakin ingin menghapus misi ini?',
              textAlign: TextAlign.center,
              style: blackTextStyle.copyWith(
                  fontSize: 16.sp, fontWeight: bold),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: redColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                    context.read<MissionBloc>().add(DeleteMission(missionId: missionId));
                    Navigator.of(context).pop();
                  },
                  child: Text('Ya',   style: whiteTextStyle.copyWith(fontSize: 14.sp),),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: grayColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Batal',   style: whiteTextStyle.copyWith(fontSize: 14.sp),),
                ),
              ],
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }
}

