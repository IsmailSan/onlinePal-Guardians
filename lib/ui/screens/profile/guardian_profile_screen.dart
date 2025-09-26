import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/profile_event.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/profile_state.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/ui/screens/avatar/avatar_collection_screen.dart';
import 'package:online_pal_guardians/ui/widgets/dropdown_list_field.dart';
import 'package:online_pal_guardians/ui/widgets/custom_form_field.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/success_dialog.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class GuardianProfileScreen extends StatefulWidget {
  final bool isUpdateProfile;

  const GuardianProfileScreen({Key? key, this.isUpdateProfile = false})
      : super(key: key);

  @override
  State<GuardianProfileScreen> createState() => _GuardianProfileScreenState();
}

class _GuardianProfileScreenState extends State<GuardianProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime selectedBirthDate = DateTime.now();
  final nameController = TextEditingController(text: '');
  final nationalityController = TextEditingController(text: '');
  final provinceController = TextEditingController(text: '');
  final cityController = TextEditingController(text: '');
  final postalCodeController = TextEditingController(text: '');
  final jobController = TextEditingController(text: '');
  final familyIncomeRangeController = TextEditingController(text: '');
  final numberOfChildrenController = TextEditingController(text: '');

  String gender = 'man';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedBirthDate,
      firstDate: DateTime(1700),
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
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ProfileBloc(
          profileRepository: context.read(),
        );
        if (widget.isUpdateProfile) {
          bloc.add(GetProfile());
        }
        return bloc;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // if (!widget.isUpdateProfile) const SizedBox(height: 16),
                // if (!widget.isUpdateProfile)
                //   Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(horizontal: 12.w),
                //     child:
                //     Stack(
                //       children: [
                //         Align(
                //           alignment: Alignment.center,
                //           child: Image.asset(
                //             'assets/mini_logo.png',
                //             height: 30.h,
                //           ),
                //         ),
                //         Align(
                //           alignment: Alignment.centerLeft,
                //           child: GestureDetector(
                //             onTap: () {
                //               Navigator.pop(context);
                //             },
                //             child: Row(
                //               mainAxisSize: MainAxisSize.min,
                //               children: [
                //                 const Icon(Icons.arrow_back_ios, size: 18.0),
                //                 SizedBox(width: 4.w),
                //                 Text(
                //                   'KEMBALI',
                //                   style: blackTextStyle.copyWith(
                //                       fontSize: 17.sp, fontWeight: regular),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // const SizedBox(height: 20),
                // if (!widget.isUpdateProfile)
                //   Text(
                //     'Profil',
                //     style: blackTextStyle.copyWith(
                //         fontSize: 17.sp, fontWeight: semiBold),
                //   ),
                // if (!widget.isUpdateProfile)
                const SizedBox(height: 10),
                Expanded(
                    child: BlocConsumer<ProfileBloc, ProfileState>(
                        listener: (context, state) {
                  if (state is GetProfileSuccess) {
                    nameController.text = nameController.text.isEmpty
                        ? state.getProfileResponse.data.name ?? ''
                        : nameController.text;
                    nationalityController.text =
                        nationalityController.text.isEmpty
                            ? state.getProfileResponse.data.nationality ?? ''
                            : nationalityController.text;
                    provinceController.text = provinceController.text.isEmpty
                        ? state.getProfileResponse.data.province ?? ''
                        : provinceController.text;
                    cityController.text = cityController.text.isEmpty
                        ? state.getProfileResponse.data.city ?? ''
                        : cityController.text;
                    postalCodeController.text =
                        postalCodeController.text.isEmpty
                            ? state.getProfileResponse.data.postalCode ?? ''
                            : postalCodeController.text;
                    jobController.text = jobController.text.isEmpty
                        ? state.getProfileResponse.data.occupation ?? ''
                        : jobController.text;
                    familyIncomeRangeController.text =
                        familyIncomeRangeController.text.isEmpty
                            ? state.getProfileResponse.data
                                    .rangeOfFamilyIncome ??
                                ''
                            : familyIncomeRangeController.text;
                    numberOfChildrenController.text =
                        numberOfChildrenController.text.isEmpty
                            ? (state.getProfileResponse.data.numberOfChildren
                                    .toString() ??
                                '')
                            : numberOfChildrenController.text;
                    gender ??= state.getProfileResponse.data.gender;
                    SessionHelper().saveGender(gender ?? "");
                    selectedBirthDate = DateTime.tryParse(
                            state.getProfileResponse.data.dateOfBirth ?? '') ??
                        selectedBirthDate;
                  } else if (state is GetProfileError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
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
                              CustomFormField(
                                label: 'Nama Orang Tua/Wali',
                                hintText: '',
                                controller: nameController,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Nama Orang Tua/Wali wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25.h),
                              Text(
                                "Tanggal Lahir",
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
                                "Jenis Kelamin",
                                style: blackTextStyle.copyWith(
                                    fontSize: 20.sp, fontWeight: regular),
                              ),
                              SizedBox(height: 10.h),
                              DropdownListField(
                                value: gender,
                                items: const [
                                  {'value': 'man', 'label': 'Laki-laki'},
                                  {'value': 'woman', 'label': 'Perempuan'},
                                ],
                                onChanged: (value) async {
                                  setState(() {
                                    gender = value ?? "";
                                  });
                                },
                              ),
                              SizedBox(height: 25.h),
                              CustomFormField(
                                label: 'Negara',
                                hintText: '',
                                controller: nationalityController,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Nama Negara wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25.h),
                              CustomFormField(
                                label: 'Provinsi',
                                hintText: '',
                                controller: provinceController,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Nama Provinsi wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25.h),
                              CustomFormField(
                                label: 'Kota/Kabupaten',
                                hintText: '',
                                controller: cityController,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Nama Kota wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25.h),
                              CustomFormField(
                                label: 'Kode Pos',
                                hintText: '',
                                controller: postalCodeController,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Kode wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25.h),
                              CustomFormField(
                                label: 'Pekerjaan',
                                hintText: '',
                                controller: jobController,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Pekerjaan wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25.h),
                              CustomFormField(
                                label: 'Rentang penghasilan keluarga',
                                hintText: '',
                                controller: familyIncomeRangeController,
                                isNumeric: false,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Penghasilan keluarga wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 25.h),
                              CustomFormField(
                                label: 'Jumlah Anak',
                                hintText: '',
                                controller: numberOfChildrenController,
                                isNumeric: true,
                                validator: (val) {
                                  if (val == null || val.isEmpty) {
                                    return 'Jumlah anak wajib diisi';
                                  }
                                  return null;
                                },
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
                                                          isUpdateProfile:
                                                              true)));
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
                                          'Ubah Avatar',
                                          style: blackTextStyle.copyWith(
                                              fontSize: 20.sp,
                                              fontWeight: bold),
                                        ),
                                      ),
                                    ),
                                  SizedBox(height: 20.h),
                                  BlocConsumer<ProfileBloc, ProfileState>(
                                    listener: (context, state) {
                                      if (state is UpdateProfileSuccess) {
                                        final session = SessionHelper();
                                        session.setGuardianProfileFilled(true);

                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (_) => SuccessDialog(
                                              message:
                                                  'Profil Berhasil Diperbarui'),
                                        );
                                      } else if (state is ProfileError) {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (_) => ErrorDialog(
                                              message: state.message),
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      return Center(
                                        child: SizedBox(
                                          width: 250.w,
                                          height: 55.h,
                                          child: OutlinedButton(
                                            onPressed: state is ProfileLoading
                                                ? null
                                                : () {
                                                    if (_formKey.currentState
                                                            ?.validate() !=
                                                        true) {
                                                      return;
                                                    }
                                                    // if (nameController.text.isEmpty ||
                                                    //     gender == null ||
                                                    //     nationalityController
                                                    //         .text.isEmpty ||
                                                    //     provinceController
                                                    //         .text.isEmpty ||
                                                    //     cityController
                                                    //         .text.isEmpty ||
                                                    //     postalCodeController
                                                    //         .text.isEmpty ||
                                                    //     jobController
                                                    //         .text.isEmpty ||
                                                    //     familyIncomeRangeController
                                                    //         .text.isEmpty ||
                                                    //     numberOfChildrenController
                                                    //         .text.isEmpty) {
                                                    //   ScaffoldMessenger.of(
                                                    //           context)
                                                    //       .showSnackBar(
                                                    //     const SnackBar(
                                                    //       content: Text(
                                                    //           'Semua field harus diisi'),
                                                    //       backgroundColor:
                                                    //           Colors.red,
                                                    //     ),
                                                    //   );
                                                    //   return;
                                                    // }
                                                    context
                                                        .read<ProfileBloc>()
                                                        .add(
                                                            ProfileSubmitButtonPressed(
                                                          name: nameController
                                                              .text,
                                                          dateOfBirth:
                                                              selectedBirthDate
                                                                  .toIso8601String(),
                                                          gender: gender,
                                                          nationality:
                                                              nationalityController
                                                                  .text,
                                                          province:
                                                              provinceController
                                                                  .text,
                                                          city: cityController
                                                              .text,
                                                          postalCode:
                                                              postalCodeController
                                                                  .text,
                                                          occupation:
                                                              jobController
                                                                  .text,
                                                          rangeOfFamilyIncome:
                                                              familyIncomeRangeController
                                                                  .text,
                                                          numberOfChildren:
                                                              int.tryParse(
                                                                      numberOfChildrenController
                                                                          .text) ??
                                                                  0,
                                                        ));
                                                  },
                                            style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.black),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              backgroundColor: Colors.white,
                                            ),
                                            child: state is ProfileLoading
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
                })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
