import 'package:flutter/material.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationDetailDialog extends StatelessWidget {
  final String avatarAsset;
  final String date;
  final String profile;
  final String mission;
  final String period;
  final String title;
  final VoidCallback onGoToMission;

  const NotificationDetailDialog({
    Key? key,
    required this.avatarAsset,
    required this.date,
    required this.profile,
    required this.mission,
    required this.period,
    required this.title,
    required this.onGoToMission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 300.h,
        decoration: BoxDecoration(
          color: lightBlueColor, // Light lavender background
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${title}',
                    style: blackTextStyle.copyWith(
                        fontSize: 14.sp, fontWeight: bold),
                  ),
                ),
                // CircleAvatar(
                //   radius: 24,
                //   backgroundImage: AssetImage('assets/avatar_boy.png'),
                // ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow("Tanggal", date),
                _buildInfoRow("Profil", profile),
                _buildInfoRow("Misi", mission),
                _buildInfoRow("Periode", period),
              ],
            ),
            Divider(height: 10, color: grayColor,),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      onGoToMission();
                    },
                    child: Text("Lihat",   style: grayTextStyle.copyWith(
                        fontSize: 12.sp, fontWeight: medium, fontStyle: italic),)),
                  ),
                Container(height: 60, width: 1, color: grayColor),
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Tutup", style: grayTextStyle.copyWith(
                        fontSize: 12.sp, fontWeight: medium, fontStyle: italic)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 70, child: Text('$label :',   style: blackTextStyle.copyWith(
              fontSize: 12.sp, fontWeight: regular),)),
          Expanded(child: Text(value,   style: blackTextStyle.copyWith(
              fontSize: 14.sp, fontWeight: regular),)),
        ],
      ),
    );
  }
}
