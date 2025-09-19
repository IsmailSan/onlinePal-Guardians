import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class SliderChildItem extends StatelessWidget {
  final int points;
  final String name;
  final String? hpTime;
  final String? tabletTime;
  final String? lastHp;
  final String? lastTablet;
  final String? parentAvatarUrl;
  final String? childAvatarUrl;
  final List<String>? favoritePhysicalActivities;
  final List<String>? hobbies;

  const SliderChildItem({
    super.key,
    required this.points,
    required this.name,
    required this.hpTime,
    required this.tabletTime,
    required this.lastHp,
    required this.lastTablet,
    required this.parentAvatarUrl,
    required this.childAvatarUrl,
    this.favoritePhysicalActivities,
    this.hobbies,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: pastelPurple,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.17),
                blurRadius: 10,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ✅ Avatar
              SizedBox(
                width: 100,
                height: 100,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    if (parentAvatarUrl != null && parentAvatarUrl!.isNotEmpty)
                      ClipOval(
                        child: Image.network(
                          parentAvatarUrl!,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.person, size: 90),
                        ),
                      ),
                    if (childAvatarUrl != null && childAvatarUrl!.isNotEmpty)
                      Positioned(
                        bottom: -15,
                        right: -10,
                        child: ClipOval(
                          child: Image.network(
                            childAvatarUrl!,
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                            const Icon(Icons.person, size: 70),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // ✅ Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: blackTextStyle.copyWith(
                        fontSize: 16.sp,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ✅ Aktivitas Favorit
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Aktivitas Favorit: ",
                          style: blackTextStyle.copyWith(fontSize: 14.sp),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            (favoritePhysicalActivities != null && favoritePhysicalActivities!.isNotEmpty)
                                ? favoritePhysicalActivities!.join(', ')
                                : '-', // atau kosong: ''
                            style: whiteTextStyle.copyWith(fontSize: 14.sp),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(height: 6),

                    // ✅ Hobi

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hobi: ",
                          style: blackTextStyle.copyWith(fontSize: 14.sp),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            (hobbies != null && hobbies!.isNotEmpty) ? hobbies!.join(', ') : '-',
                            style: whiteTextStyle.copyWith(fontSize: 14.sp),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
