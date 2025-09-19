import 'package:flutter/material.dart';
import 'package:online_pal_guardians/models/schedule/schedule_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/schedule/schedule_input_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScheduleDetailDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String timeRange,
    required String repeatText,
    required String note,
    required String lastUpdate,
    required int scheduleId,
    required Schedule schedule,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: const Color(0xFFE5E6FF),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,   style: blackTextStyle.copyWith(
                        fontSize: 20.sp, fontWeight: bold),),
                    GestureDetector(
                      onTap: () => Navigator.of(dialogContext).pop(),
                      child: const Icon(Icons.close, size: 20),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Text("Waktu  : $timeRange",   style: blackTextStyle.copyWith(
                    fontSize: 18.sp, fontWeight: light, fontStyle: italic)),
                const SizedBox(height: 4),
                Text("$repeatText", style: blackTextStyle.copyWith(
                    fontSize: 18.sp, fontWeight: light, fontStyle: italic)),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: lightBlueColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "",
                        style: blackTextStyle.copyWith(
                            fontSize: 16.sp, fontWeight: regular, fontStyle: italic),
                      ),
                      Text(
                        note,
                        style: blackTextStyle.copyWith(
                            fontSize: 16.sp, fontWeight: regular),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Last Update: $lastUpdate",
                  style: const TextStyle(fontSize: 11, color: Colors.black38, fontStyle: FontStyle.italic),
                ),
                const SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 160,
                    height: 45,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (dialogContext) => ScheduleInputScreen(isEdit: true, scheduleId: scheduleId, schedule: schedule,)));
                        // _navigatorKey.currentState!
                        //     .pushNamed('/findActivity');
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Edit',
                        style: blackTextStyle.copyWith(
                            fontSize: 18, fontWeight: bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
