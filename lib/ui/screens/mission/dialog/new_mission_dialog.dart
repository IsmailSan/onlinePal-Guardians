import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class NewMissionDialog {
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
                  "Bagaimana cara membuat misi?",
                  style: blackTextStyle.copyWith(
                      fontSize: 12.sp, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                SingleChildScrollView(
                  child: Text(
                    """Dalam aplikasi ini, Anda berperan sebagai pembuat misi untuk menantang anak Anda untuk mengelola penggunaan gadget/internet mereka dengan tepat.  

Anda disarankan untuk membuat aturan penggunaan gadget/internet tertentu sebagai misi yang menarik disertai dengan poin, hadiah, atau hukuman. Poin yang dikumpulkan anak nantinya dapat ditukarkan dengan daftar hadiah yang Anda sediakan (lihat menu “Hadiah&Hukuman”). Pemberian hadiah dan hukuman dari misi mereka bertujuan untuk meningkatkan motivasi anak dalam mengelola penggunaan gadget/internet mereka.

Untuk memastikan anak memahami misi atau aturan yang Anda berikan, mereka harus menerima/menolak misi tersebut melalui perangkat mereka. Anda disarankan untuk memberikan penjelasan yang memadai terkait misi/aturan yang diberikan.

Untuk membantu Anda membuat misi, kami menyediakan sugesti misi-misi yang mungkin cocok dengan Anda sesuai dengan data goals dan profil yang Anda masukan. Anda dapat membuat misi dari sugesti yang kami sediakan atau membuatnya sesuai dengan keinginan Anda.

Lima (5) langkah mudah membuat misi:
1. Tekan ‘Buat misi baru’, lalu pilihlah apakah Anda ingin menggunakan misi yang disarankan oleh sistem atau membuat misi sendiri (Anda tetap bisa mengubah detail dari misi yang disarankan setelah dipilih).
2. Masukan detail dari misi, seperti tipe, kondisi khusus, periode waktu, aplikasi yang dituju, poin, hadiah langsung, dan hukuman langsung yang akan diberlakukan.
3. Mintalah anak Anda untuk menerima misi tersebut. Mereka dapat menolak misi tersebut dengan memberikan alasan tertentu.
4. Setelah anak Anda menerima misi tersebut, Anda akan diberi notifikasi dan misi akan aktif pada periode yang ditentukan. Anda dapat mengecek progres setiap misi kapan saja melalui aplikasi.
5. Jangan lupa untuk memberikan hadiah/hukuman yang telah Anda 
terapkan pada anak Anda. Anda dapat menandai hadiah/hukuman mana yang sudah diberikan atau belum pada menu “Hadiah&Hukuman”.""",
                    style: blackTextStyle.copyWith(
                        fontSize: 10.sp, fontWeight: FontWeight.normal),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child:
                    Text(
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
