import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';

class ChildProfileDropdown extends StatelessWidget {
  final List<ChildProfile> profiles;
  final int? selectedProfileId;
  final void Function(ChildProfile) onProfileSelected;
  final VoidCallback onAddNew;

  const ChildProfileDropdown({
    super.key,
    required this.profiles,
    required this.selectedProfileId,
    required this.onProfileSelected,
    required this.onAddNew,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;

        showMenu<ChildProfile>(
          context: context,
          position: RelativeRect.fromRect(
            details.globalPosition & const Size(40, 40),
            Offset.zero & overlay.size,
          ),
          color: Colors.transparent,
          elevation: 0,
          items: [
            PopupMenuItem(
              enabled: false,
              padding: EdgeInsets.zero,
              child: Container(
                decoration: BoxDecoration(
                  color: lightBlueColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Text(
                        "Pilih Profil Anak:",
                        style: blackTextStyle.copyWith(
                          fontSize: 10.sp,
                          fontWeight: bold,
                        ),
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 300.h,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Divider(
                                height: 1, thickness: 0.5, color: grayColor),
                            ...profiles.map((profile) => Column(
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.pop(context, profile);
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 12.w,
                                            vertical: 10.h,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                profile.name,
                                                style: blackTextStyle.copyWith(
                                                    fontSize: 12.sp),
                                              ),
                                              SizedBox(width: 2),
                                              if (selectedProfileId != null &&
                                                  profile.id ==
                                                      selectedProfileId)
                                                const Icon(Icons.check,
                                                    size: 14),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                        height: 1,
                                        thickness: 0.5,
                                        color: grayColor),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => Navigator.pop(context, '__add__'),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 8.w,
                          ),
                          child: Text(
                            "+ Tambah profil baru",
                            style: blackTextStyle.copyWith(fontSize: 12.sp),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).then((value) {
          if (value != null) {
            if (value is String && value == '__add__') {
              onAddNew();
            } else
              onProfileSelected(value); // butuh ubah parameter di konstruktor
          }
        });
      },
      child: SvgPicture.asset(
        'assets/profile_icon.svg',
        fit: BoxFit.cover,
      ),
    );
  }
}
