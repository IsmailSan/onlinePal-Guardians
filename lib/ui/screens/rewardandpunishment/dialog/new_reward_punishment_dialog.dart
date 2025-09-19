import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class NewRewardPunishmentDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: lightBlueColor,
          child: Padding(
            padding: EdgeInsets.all(16.0.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Bagaimana cara membuat hadiah dan hukuman?",
                  style: blackTextStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                SingleChildScrollView(
                  child: Text(
                    """1. Di OnlinePal, Anda dapat membuat hadiah dan hukuman untuk anak sebagai apresiasi atau konsekuensi dari misi yang mereka lakukan. Pemberian hadiah dan hukuman dapat meningkatkan motivasi dan pengalaman anak dalam melakukan perilaku yang diharapkan.

2. Hadiah dapat diberikan dalam bentuk: 
(1) Penukaran poin dengan hadiah yang telah ditentukan orang tua sebelumnya. 
(2) Pemberian hadiah langsung atas misi tertentu yang telah ditentukan orang tua sebelumnya. 

3. Hukuman dapat diberikan dalam bentuk:
(1) Hukuman spesifik dalam bentuk tertentu dari orang tua yang telah ditentukan orang tua sebelumnya. 
(2) Reduksi poin yang telah dikumpulkan anak. 

4. Langkah mudah untuk membuat hadiah dan hukuman:
  1. Pilih ‘Buat kondisi hadiah’ atau ‘Buat kondisi hukuman’.
  2. [Hadiah] masukkan ketentuan hadiah yang hendak diberikan, seperti periode berlaku, bentuk hadiah, poin yang dibutuhkan untuk menukar hadiah / misi yang harus dilakukan untuk mendapatkan hadiah, dan catatan lain yang perlu disampaikan.
  3. [Hukuman] masukkan ketentuan hukuman yang hendak diberikan, seperti periode berlaku, bentuk hukuman, pengurangan poin, misi yang terkait dengan hukuman, dan catatan lain yang perlu disampaikan.
  4. Notifikasi dan daftar kondisi hadiah dan hukuman akan otomatis muncul pada perangkat anak, dan mereka akan diingatkan secara berkala terkait hadiah/hukuman tersebut.
  5. Perubahan poin, hadiah, dan hukuman akan otomatis diperbaharui oleh OnlinePal sesuai ketentuan. Namun, orangtua/wali tetap perlu memberi info pada sistem ketika telah memberikan hadiah/hukuman tertentu.
  6. Jangan sampai lupa menepati hadiah/hukuman pada anak! Enjoy :)""",
                    style: blackTextStyle.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      "Tutup",
                      style: blackTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
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
