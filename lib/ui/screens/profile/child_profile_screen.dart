import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_event.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_state.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/ui/screens/avatar/avatar_collection_screen.dart';
import 'package:online_pal_guardians/ui/widgets/dropdown_list_field.dart';
import 'package:online_pal_guardians/ui/widgets/custom_form_field.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class ChildProfileScreen extends StatefulWidget {
  final bool isUpdateProfile;
  final bool isRegistration;

  const ChildProfileScreen(
      {Key? key, this.isUpdateProfile = false, this.isRegistration = false})
      : super(key: key);

  @override
  State<ChildProfileScreen> createState() => _ChildProfileScreenState();
}

class _ChildProfileScreenState extends State<ChildProfileScreen> {
  DateTime selectedBirthDate = DateTime.now();
  final userNameController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');
  final passwordConfirmationController = TextEditingController(text: '');
  final nameController = TextEditingController(text: '');
  final childGradeLevelController = TextEditingController(text: '');
  final schoolNameController = TextEditingController(text: '');

  String? gender;
  String? livingWithParents;
  int? childProfileId;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedBirthDate) {
      setState(() {
        selectedBirthDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final profile = await SessionHelper().getChildProfile();
      final id = profile?.id;

      if (id != null) {
        setState(() {
          childProfileId = id;
        });

        if (widget.isUpdateProfile) {
          context.read<ChildProfileBloc>().add(GetChildProfile(id: id));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            if (!widget.isUpdateProfile && !widget.isRegistration)
              const SizedBox(height: 16),
            if (!widget.isUpdateProfile && !widget.isRegistration)
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/mini_logo.png',
                        height: 30.h,
                      ),
                    ),
                    // Kembali di kiri
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.arrow_back_ios, size: 18.0),
                            SizedBox(width: 4.w),
                            Text(
                              'KEMBALI',
                              style: blackTextStyle.copyWith(
                                  fontSize: 17.sp, fontWeight: regular),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            if (!widget.isUpdateProfile && !widget.isRegistration)
              Text(
                'Input Profil Anak',
                style: blackTextStyle.copyWith(
                    fontSize: 17.sp, fontWeight: semiBold),
              ),
            if (!widget.isUpdateProfile && !widget.isRegistration)
              const SizedBox(height: 30),
            Expanded(
              child: BlocConsumer<ChildProfileBloc, ChildProfileState>(
                  listener: (context, state) {
                if (state is GetChildProfileSuccess) {
                  nameController.text = nameController.text.isEmpty
                      ? state.response.data.name
                      : nameController.text;
                  childGradeLevelController.text =
                      childGradeLevelController.text.isEmpty
                          ? state.response.data.grade
                          : childGradeLevelController.text;
                  schoolNameController.text = schoolNameController.text.isEmpty
                      ? state.response.data.school
                      : schoolNameController.text;
                  gender ??= state.response.data.gender;
                  selectedBirthDate =
                      DateTime.tryParse(state.response.data.dateOfBirth) ??
                          selectedBirthDate;
                  livingWithParents ??= state.response.data.liveWithParents;
                  SessionHelper().saveChildGender(gender ?? "");
                }
              }, builder: (context, state) {
                return SingleChildScrollView(
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: !widget.isUpdateProfile ? 24 : 0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!widget.isUpdateProfile) ...[
                              CustomFormField(
                                label: 'Username',
                                hintText: '',
                                controller: userNameController,
                              ),
                              SizedBox(height: 25.h),
                              CustomFormField(
                                label: 'Password',
                                hintText: '',
                                controller: passwordController,
                                isPassword: true,
                              ),
                              SizedBox(height: 25.h),
                              CustomFormField(
                                label: 'Konfirmasi Password',
                                hintText: '',
                                controller: passwordConfirmationController,
                                isPassword: true,
                              ),
                              SizedBox(height: 25.h),
                            ],
                            CustomFormField(
                              label: 'Nama Anak Anda',
                              hintText: '',
                              controller: nameController,
                            ),
                            SizedBox(height: 25.h),
                            Text(
                              "Tanggal Lahir Anak",
                              style: blackTextStyle.copyWith(
                                  fontSize: 20.sp, fontWeight: regular),
                            ),
                            SizedBox(height: 10.h),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 16.h),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border(
                                      bottom:
                                          BorderSide(color: lightBlueColor)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${selectedBirthDate.day.toString().padLeft(2, '0')}/${selectedBirthDate.month.toString().padLeft(2, '0')}/${selectedBirthDate.year}",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16.sp),
                                    ),
                                    Icon(Icons.calendar_today,
                                        color: Colors.indigo, size: 20.sp),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 25.h),
                            Text(
                              "Jenis Kelamin Anak",
                              style: blackTextStyle.copyWith(
                                  fontSize: 20.sp, fontWeight: regular),
                            ),
                            SizedBox(height: 10.h),
                            DropdownListField(
                              value: gender,
                              items: const [
                                {'value': 'boy', 'label': 'Laki-laki'},
                                {'value': 'girl', 'label': 'Perempuan'},
                              ],
                              onChanged: (value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                            SizedBox(height: 25.h),
                            Text(
                              "Apakah Anda Tinggal dengan Anak",
                              style: blackTextStyle.copyWith(
                                  fontSize: 20.sp, fontWeight: regular),
                            ),
                            SizedBox(height: 10.h),
                            DropdownListField(
                              value: livingWithParents,
                              items: const [
                                {'value': 'yes', 'label': 'Iya'},
                                {'value': 'no', 'label': 'Tidak'},
                              ],
                              onChanged: (value) {
                                setState(() {
                                  livingWithParents = value;
                                });
                              },
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Kelas Berapa Anak Anda Berada?',
                              hintText: '',
                              controller: childGradeLevelController,
                              isNumeric: true,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Nama Sekolah Anak',
                              hintText: '',
                              controller: schoolNameController,
                            ),
                            SizedBox(height: 40.h),
                            Column(
                              children: [
                                if (widget.isUpdateProfile)
                                  SizedBox(
                                    width: 250.w,
                                    height: 55.h,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const AvatarCollectionScreen(
                                                      isUpdateProfile: true,
                                                      isParent: false,
                                                    )));
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.black),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        backgroundColor: Colors.white,
                                      ),
                                      child: Text(
                                        'Ubah Avatar Anak',
                                        style: blackTextStyle.copyWith(
                                            fontSize: 20.sp, fontWeight: bold),
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 20.h),
                                BlocConsumer<ChildProfileBloc,
                                    ChildProfileState>(
                                  listener: (context, state) {
                                    if (state is CreateChildProfileSuccess) {
                                      final session = SessionHelper();
                                      session.setChildProfileFilled(true);
                                      session.saveProfileId(
                                          state.response.data.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Profil anak berhasil dibuat"),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else if (state
                                        is UpdateChildProfileSuccess) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              "Profil berhasil diperbarui"),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                    } else if (state is ChildProfileError) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(state.message),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    return Center(
                                      child: SizedBox(
                                        width: 250.w,
                                        height: 55.h,
                                        child: OutlinedButton(
                                          onPressed: () {
                                            if ((!widget.isUpdateProfile &&
                                                    (userNameController
                                                            .text.isEmpty ||
                                                        passwordController
                                                            .text.isEmpty ||
                                                        passwordConfirmationController
                                                            .text.isEmpty)) ||
                                                nameController.text.isEmpty ||
                                                gender == null ||
                                                livingWithParents == null ||
                                                childGradeLevelController
                                                    .text.isEmpty ||
                                                schoolNameController
                                                    .text.isEmpty) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Semua field wajib diisi"),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              return;
                                            }

                                            if (!widget.isUpdateProfile &&
                                                passwordController.text.length <
                                                    6) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Password minimal 6 karakter"),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              return;
                                            }

                                            final bloc = context
                                                .read<ChildProfileBloc>();

                                            if (widget.isUpdateProfile) {
                                              if (childProfileId != null) {
                                                bloc.add(UpdateChildProfile(
                                                  name: nameController.text,
                                                  dateOfBirth: selectedBirthDate
                                                      .toIso8601String(),
                                                  gender: gender ?? "",
                                                  liveWithParents:
                                                      livingWithParents ?? "",
                                                  grade:
                                                      childGradeLevelController
                                                          .text,
                                                  school:
                                                      schoolNameController.text,
                                                  id: childProfileId!,
                                                ));
                                              }
                                            } else {
                                              bloc.add(CreateChildProfile(
                                                username:
                                                    userNameController.text,
                                                password:
                                                    passwordController.text,
                                                passwordConfirmation:
                                                    passwordConfirmationController
                                                        .text,
                                                name: nameController.text,
                                                dateOfBirth: selectedBirthDate
                                                    .toIso8601String(),
                                                gender: gender ?? "",
                                                liveWithParents:
                                                    livingWithParents ?? "",
                                                grade: childGradeLevelController
                                                    .text,
                                                school:
                                                    schoolNameController.text,
                                              ));
                                            }
                                          },
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Colors.black),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8),
                                            backgroundColor: Colors.white,
                                          ),
                                          child: state is ChildProfileLoading
                                              ? SizedBox(
                                                  width: 24.w,
                                                  height: 24.w,
                                                  child:
                                                      CircularProgressIndicator(
                                                    strokeWidth: 2.5,
                                                    valueColor:
                                                        AlwaysStoppedAnimation(
                                                            strongPurpleColor),
                                                  ),
                                                )
                                              : Text(
                                                  widget.isUpdateProfile
                                                      ? 'Selesai'
                                                      : 'Simpan',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                          fontSize: 18.sp,
                                                          fontWeight: bold),
                                                ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 55.h),
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
