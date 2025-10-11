import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_event.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_state.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/ui/widgets/success_dialog.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class PreferenceScreen extends StatefulWidget {
  final bool isUpdateProfile;
  final bool isRegistration;

  const PreferenceScreen(
      {Key? key, this.isUpdateProfile = false, this.isRegistration = false})
      : super(key: key);

  @override
  State<PreferenceScreen> createState() => _PreferenceScreenState();
}

class _PreferenceScreenState extends State<PreferenceScreen> {
  int? childProfileId;
  late SessionHelper session;

  final List<String> physicalActivityLabels = [
    'Gymnastic',
    'Basket',
    'Sepakbola',
    'Berenang',
    'Mendaki',
    'Bermain di Luar',
    'Bulu Tangkis',
    'Skuter',
    'Menari',
    'Lompat tali',
    'Tenis',
    'Lari',
    'Bermain peran',
    'Bersepeda',
    'Berkebun',
  ];

  final List<String> hobbyLabels = [
    'Olahraga',
    'Desain',
    'Bermusik',
    'Berenang',
    'Bersosialisasi',
    'Membaca',
    'Programming',
    'Fotografi',
    'Makan',
    'Bernyanyi',
    'Menari',
  ];

  final List<String> familyActivityLabels = [
    'Bepergian',
    'Belanja',
    'Belajar',
    'Bermain di luar',
    'Menonton',
    'Menari',
    'Bercerita',
  ];

  final List<String> onlineActivityLabels = [
    'Belajar Online',
    'Bermain Game',
    'Media Sosial',
    'Menonton',
    'Mendesain',
    'Chatting',
    'Video Call',
    'Foto & Video',
    'Berdoa',
    'Musik/lagu',
    'Belanja',
  ];

  List<String> favoritePhysicialActivities = [];
  List<String> favoriteHobbies = [];
  List<String> favoriteFamilyActivities = [];
  List<String> favoriteOnlineActivities = [];

  void togglePhysicalActivity(String activity) {
    setState(() {
      if (favoritePhysicialActivities.contains(activity)) {
        favoritePhysicialActivities.remove(activity);
      } else {
        favoritePhysicialActivities.add(activity);
      }
    });
  }

  void toggleHobby(String activity) {
    setState(() {
      if (favoriteHobbies.contains(activity)) {
        favoriteHobbies.remove(activity);
      } else {
        favoriteHobbies.add(activity);
      }
    });
  }

  void toggleFamilyActivity(String activity) {
    setState(() {
      if (favoriteFamilyActivities.contains(activity)) {
        favoriteFamilyActivities.remove(activity);
      } else {
        favoriteFamilyActivities.add(activity);
      }
    });
  }

  void toggleOnlineActivity(String activity) {
    setState(() {
      if (favoriteOnlineActivities.contains(activity)) {
        favoriteOnlineActivities.remove(activity);
      } else {
        favoriteOnlineActivities.add(activity);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    session = SessionHelper();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final profile = await SessionHelper().getChildProfile();
      childProfileId = profile?.id;

      if (childProfileId != null) {
        context
            .read<ChildProfileBloc>()
            .add(GetChildProfile(id: childProfileId ?? 0));
      }
    });
  }

  @override
  void dispose() {
    final session = SessionHelper();
    session.deleteProfileId();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChildProfileBloc, ChildProfileState>(
      listener: (context, state) {
        if (state is GetChildProfileSuccess) {
          final profile = state.response.data;

          setState(() {
            favoritePhysicialActivities =
                List<String>.from(profile?.favoritePhysicalActivities ?? []);
            favoriteHobbies = List<String>.from(profile?.hobbies ?? []);
            favoriteFamilyActivities =
                List<String>.from(profile?.favoriteFamilyActivities ?? []);
            favoriteOnlineActivities =
                List<String>.from(profile?.favoriteOnlineActivities ?? []);
          });
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'Aktivitas fisik favorit anak Anda:',
                          style: blackTextStyle.copyWith(
                            fontSize: 21.sp,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GridView.builder(
                      itemCount: physicalActivityLabels.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 3,
                      ),
                      itemBuilder: (context, index) {
                        final activity = physicalActivityLabels[index];
                        final isSelected =
                            favoritePhysicialActivities.contains(activity);

                        return GestureDetector(
                          onTap: () => togglePhysicalActivity(activity),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? purpleColor : lightBlueColor,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isSelected
                                    ? whiteColor
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              activity,
                              textAlign: TextAlign.center,
                              style: blackTextStyle.copyWith(
                                fontSize: 12.sp,
                                color: isSelected ? Colors.white : blackColor,
                                fontWeight: isSelected ? FontWeight.bold : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'Hobi anak Anda:',
                          style: blackTextStyle.copyWith(
                            fontSize: 21.sp,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GridView.builder(
                      itemCount: hobbyLabels.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 3,
                      ),
                      itemBuilder: (context, index) {
                        final activity = hobbyLabels[index];
                        final isSelected = favoriteHobbies.contains(activity);

                        return GestureDetector(
                          onTap: () => toggleHobby(activity),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? purpleColor : lightBlueColor,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isSelected
                                    ? whiteColor
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              activity,
                              textAlign: TextAlign.center,
                              style: blackTextStyle.copyWith(
                                fontSize: 12.sp,
                                color: isSelected ? Colors.white : blackColor,
                                fontWeight: isSelected ? FontWeight.bold : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'Acara keluarga favorit anak Anda:',
                          style: blackTextStyle.copyWith(
                            fontSize: 21.sp,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GridView.builder(
                      itemCount: familyActivityLabels.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 3,
                      ),
                      itemBuilder: (context, index) {
                        final activity = familyActivityLabels[index];
                        final isSelected =
                            favoriteFamilyActivities.contains(activity);

                        return GestureDetector(
                          onTap: () => toggleFamilyActivity(activity),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? purpleColor : lightBlueColor,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isSelected
                                    ? whiteColor
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              activity,
                              textAlign: TextAlign.center,
                              style: blackTextStyle.copyWith(
                                fontSize: 12.sp,
                                color: isSelected ? Colors.white : blackColor,
                                fontWeight: isSelected ? FontWeight.bold : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 20.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          'Acara online favorit anak Anda:',
                          style: blackTextStyle.copyWith(
                            fontSize: 21.sp,
                            fontWeight: regular,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GridView.builder(
                      itemCount: onlineActivityLabels.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 3,
                      ),
                      itemBuilder: (context, index) {
                        final activity = onlineActivityLabels[index];
                        final isSelected =
                            favoriteOnlineActivities.contains(activity);

                        return GestureDetector(
                          onTap: () => toggleOnlineActivity(activity),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? purpleColor : lightBlueColor,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: isSelected
                                    ? whiteColor
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            child: Text(
                              activity,
                              textAlign: TextAlign.center,
                              style: blackTextStyle.copyWith(
                                fontSize: 12.sp,
                                color: isSelected ? Colors.white : blackColor,
                                fontWeight: isSelected ? FontWeight.bold : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 50.h),
                    BlocConsumer<ChildProfileBloc, ChildProfileState>(
                      listener: (context, state) {
                        if (state is AddChildPreferenceSuccess) {
                          final session = SessionHelper();
                          session.setPreferenceProfileFilled(true);
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text("Preferensi berhasil disimpan!"),
                          //     backgroundColor: Colors.green,
                          //   ),
                          // );

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => SuccessDialog(
                                message: 'Preferensi berhasil disimpan'),
                          );
                        } else if (state is ChildProfileError) {
                          print(state.message);
                        }
                      },
                      builder: (context, state) {
                        final isLoading = state is ChildProfileLoading;

                        return OutlinedButton(
                          onPressed: isLoading
                              ? null
                              : () async {
                                  final registeredProfileId =
                                      await session.getProfileId();

                                  // tentukan id yang dipakai
                                  final targetId = widget.isRegistration
                                      ? registeredProfileId
                                      : childProfileId;

                                  if (widget.isRegistration &&
                                      registeredProfileId == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Mohon lengkapi profil anak terlebih dahulu'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return; // stop proses
                                  }

                                  if (targetId != null) {
                                    context.read<ChildProfileBloc>().add(
                                          AddChildPreference(
                                            id: targetId,
                                            favoritePhysicalActivities:
                                                favoritePhysicialActivities,
                                            hobbies: favoriteHobbies,
                                            favoriteFamilyActivities:
                                                favoriteFamilyActivities,
                                            favoriteOnlineActivities:
                                                favoriteOnlineActivities,
                                          ),
                                        );
                                  }
                                },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            minimumSize: const Size(250, 50),
                            backgroundColor: Colors.white,
                          ),
                          child: isLoading
                              ? SizedBox(
                                  width: 24.w,
                                  height: 24.w,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation(
                                        strongPurpleColor),
                                  ),
                                )
                              : Text(
                                  'Selesai',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: bold,
                                  ),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
