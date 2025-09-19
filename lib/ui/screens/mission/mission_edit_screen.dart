import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_event.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_state.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/mission/dropdown_options.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/custom_form_field.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/ui/widgets/point_selector_field.dart';
import 'package:online_pal_guardians/ui/widgets/success_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class MissionEditScreen extends StatefulWidget {
  final Mission? mission;
  const MissionEditScreen({Key? key, this.mission}) : super(key: key);

  @override
  State<MissionEditScreen> createState() => _MissionEditScreenState();
}

class _MissionEditScreenState extends State<MissionEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _missionNameController = TextEditingController();
  final TextEditingController _appNameController = TextEditingController();
  final TextEditingController _directRewardController = TextEditingController();
  final TextEditingController _directPunishmentController =
      TextEditingController();
  final TextEditingController _pointAdditionController =
      TextEditingController();
  final TextEditingController _pointReductionController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();

  String selectedMissionTypeLabel = 'Pembatasan akses';
  String selectedConditionLabel = 'Tidak ada';
  String selectedCategoryLabel = 'Games';
  String selectedTimePeriodLabel = 'Satu hari';

  Future<void> _selectStartDate(BuildContext context) async {
    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: todayDateOnly,
      firstDate: todayDateOnly,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: todayDateOnly,
      firstDate: todayDateOnly,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    final mission = widget.mission;

    if (mission != null) {
      _missionNameController.text = mission.name ?? '';
      _appNameController.text = mission.appName ?? '';
      _directRewardController.text = '';
      _directPunishmentController.text = '';
      _pointAdditionController.text = '0';
      _pointReductionController.text = '0';
      _noteController.text = mission.description ?? '';

      selectedStartDate = mission.startDate != null
          ? DateTime.tryParse(mission.startDate!) ?? selectedStartDate
          : selectedStartDate;

      selectedEndDate = mission.endDate != null
          ? DateTime.tryParse(mission.endDate!) ?? selectedEndDate
          : selectedEndDate;

      selectedMissionTypeLabel = missionTypeMap.entries
          .firstWhere(
            (e) => e.value == mission.type,
            orElse: () => const MapEntry('Pembatasan akses', 'Restrict access'),
          )
          .key;

      selectedConditionLabel = missionConditionMap.entries
          .firstWhere(
            (e) => e.value == mission.condition,
            orElse: () => const MapEntry('Tidak ada', 'No specific conditions'),
          )
          .key;

      selectedCategoryLabel = appCategoryMap.entries
          .firstWhere(
            (e) => e.value == mission.appCategory,
            orElse: () => const MapEntry('Games', 'Games'),
          )
          .key;

      selectedTimePeriodLabel = timePeriodMap.entries
          .firstWhere(
            (e) => e.value == mission.periodeTime,
            orElse: () => const MapEntry('Satu hari', 'One Day'),
          )
          .key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/top_bg_wave.png',
              fit: BoxFit.cover,
              height: 150.h,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 21, left: 21, top: 60),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Buat Misi Baru",
                        style: blackTextStyle.copyWith(
                            fontSize: 20.sp,
                            fontWeight: bold,
                            fontStyle: italic),
                      ),
                      Row(
                        children: [
                          ChildProfileSelector(),
                          SizedBox(width: 14.w),
                          MoreOptionsDropdown(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        const Icon(Icons.arrow_back_ios,
                            size: 18.0, color: Colors.black),
                        SizedBox(width: 4.w),
                        Text(
                          'Kembali',
                          style: blackTextStyle.copyWith(
                              fontSize: 16.sp, fontWeight: bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                "Input Misi Baru",
                                style: blackTextStyle.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Tipe Misi",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 18.sp, fontWeight: medium)),
                                SizedBox(height: 20.h),
                                FormField<String>(
                                  validator: (value) {
                                    if (selectedMissionTypeLabel.isEmpty) {
                                      return 'Silakan pilih tipe misi';
                                    }
                                    return null;
                                  },
                                  builder: (FormFieldState<String> state) {
                                    return Container(
                                      height: 60.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.w),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: lightBlueColor)),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: selectedMissionTypeLabel
                                                  .isNotEmpty
                                              ? selectedMissionTypeLabel
                                              : null,
                                          hint: Text("Pilih tipe misi",
                                              style: grayTextStyle),
                                          icon: const Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.indigo),
                                          style: blackTextStyle.copyWith(
                                              fontSize: 16.sp),
                                          items:
                                              missionTypeMap.keys.map((label) {
                                            return DropdownMenuItem<String>(
                                              value: label,
                                              child: Text(label),
                                            );
                                          }).toList(),
                                          onChanged: (value) {
                                            setState(() {
                                              selectedMissionTypeLabel = value!;
                                              state.didChange(
                                                  value); // trigger form update
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                            Text(
                              "Nama Misi",
                              style: blackTextStyle.copyWith(
                                  fontSize: 18.sp, fontWeight: medium),
                            ),
                            SizedBox(height: 20.h),
                            CustomFormField(
                              label: '',
                              hintText: '',
                              controller: _missionNameController,
                              readOnly: false,
                              isShowLabel: false,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Nama misi wajib diisi';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kondisi Khusus (Opsional)",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 18.sp, fontWeight: medium)),
                                SizedBox(height: 20.h),
                                Container(
                                  height: 60.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom:
                                            BorderSide(color: lightBlueColor)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedConditionLabel,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.indigo),
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16.sp),
                                      items:
                                          missionConditionMap.keys.map((label) {
                                        return DropdownMenuItem<String>(
                                          value: label,
                                          child: Text(label),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedConditionLabel = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Kategori Aplikasi",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 18.sp, fontWeight: medium)),
                                SizedBox(height: 20.h),
                                Container(
                                  height: 60.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom:
                                            BorderSide(color: lightBlueColor)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedCategoryLabel,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.indigo),
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16.sp),
                                      items: appCategoryMap.keys.map((label) {
                                        return DropdownMenuItem<String>(
                                          value: label,
                                          child: Text(label),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCategoryLabel = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Nama Aplikasi",
                              style: blackTextStyle.copyWith(
                                  fontSize: 18.sp, fontWeight: medium),
                            ),
                            SizedBox(height: 20.h),
                            CustomFormField(
                              label: '',
                              hintText: '',
                              controller: _appNameController,
                              readOnly: false,
                              isShowLabel: false,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Nama aplikasi wajib diisi';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Periode Waktu",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 18.sp, fontWeight: medium)),
                                SizedBox(height: 20.h),
                                Container(
                                  height: 60.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom:
                                            BorderSide(color: lightBlueColor)),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      value: selectedTimePeriodLabel,
                                      icon: const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: Colors.indigo),
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16.sp),
                                      items: timePeriodMap.keys.map((label) {
                                        return DropdownMenuItem<String>(
                                          value: label,
                                          child: Text(label),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedTimePeriodLabel = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.h),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Periode Misi Berlaku",
                              style: blackTextStyle.copyWith(
                                  fontSize: 18.sp, fontWeight: medium),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => _selectStartDate(context),
                                  child: Container(
                                    width: 150.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: lightBlueColor)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${selectedStartDate.day.toString().padLeft(2, '0')}/${selectedStartDate.month.toString().padLeft(2, '0')}/${selectedStartDate.year}",
                                          style: blackTextStyle.copyWith(
                                              fontSize: 16.sp),
                                        ),
                                        Image.asset(
                                          'assets/open_calendar_icon.png',
                                          width: 20.sp,
                                          height: 20.sp,
                                          color: purpleColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Text("-",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16.sp)),
                                ),
                                GestureDetector(
                                  onTap: () => _selectEndDate(context),
                                  child: Container(
                                    width: 150.w,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w, vertical: 10.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: lightBlueColor)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          selectedEndDate == null
                                              ? ""
                                              : "${selectedEndDate.day.toString().padLeft(2, '0')}/${selectedEndDate.month.toString().padLeft(2, '0')}/${selectedEndDate.year}",
                                          style: blackTextStyle.copyWith(
                                              fontSize: 16.sp),
                                        ),
                                        Image.asset(
                                          'assets/open_calendar_icon.png',
                                          width: 20.sp,
                                          height: 20.sp,
                                          color: purpleColor,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Poin per Hari dari Misi ini",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 18.sp, fontWeight: medium),
                                ),
                                Text(
                                  "Mohon input kelipatan 10",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: medium,
                                      fontStyle: italic),
                                ),
                                PointSelectorField(
                                  controller: _pointAdditionController,
                                  multiplyByTen: true,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hadiah Langsung dari Misi ini (Opsional)",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 18.sp, fontWeight: medium),
                                ),
                                Text(
                                  "Silahkan masukkan hadiah langsung keberhasilan misi",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: medium,
                                      fontStyle: italic),
                                ),
                                CustomFormField(
                                  label: '',
                                  hintText: '',
                                  controller: _directRewardController,
                                  readOnly: false,
                                  isShowLabel: false,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Hukuman Langsung dari Misi ini (Opsional)",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 18.sp, fontWeight: medium),
                                ),
                                Text(
                                  "Silahkan masukkan hukuman langsung kegagalan misi",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: medium,
                                      fontStyle: italic),
                                ),
                                CustomFormField(
                                  label: '',
                                  hintText: '',
                                  controller: _directPunishmentController,
                                  readOnly: false,
                                  isShowLabel: false,
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Pengurangan Poin per Hari dari Misi ini (Opsional)",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 18.sp, fontWeight: medium),
                                ),
                                Text(
                                  "Mohon input kelipatan 10",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight: medium,
                                      fontStyle: italic),
                                ),
                                PointSelectorField(
                                  controller: _pointReductionController,
                                  multiplyByTen: true,
                                  mode: 'minus',
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Catatan (Opsional)",
                              style: blackTextStyle.copyWith(
                                  fontSize: 18.sp, fontWeight: medium),
                            ),
                            SizedBox(height: 20.h),
                            CustomFormField(
                              label: '',
                              hintText: '',
                              controller: _noteController,
                              readOnly: false,
                              isShowLabel: false,
                              minLines: 1,
                              maxLines: null,
                            ),
                            SizedBox(height: 50.h),
                            BlocListener<MissionBloc, MissionState>(
                              listener: (context, state) {
                                if (state is CreateNewMissionSuccess) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => SuccessDialog(
                                        message: 'Misi berhasil ditambahkan'),
                                  );
                                } else if (state is MissionError) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) =>
                                        ErrorDialog(message: state.message),
                                  );
                                }
                              },
                              child: Center(
                                child: SizedBox(
                                  width: 250.w,
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState?.validate() !=
                                          true) return;

                                      final reward = int.tryParse(
                                              _pointAdditionController.text
                                                  .trim()) ??
                                          0;
                                      final punishment = int.tryParse(
                                              _pointReductionController.text
                                                  .trim()) ??
                                          0;
                                      final profile = await SessionHelper()
                                          .getChildProfile();
                                      final childUserId = profile?.userId;
                                      context
                                          .read<MissionBloc>()
                                          .add(UpdateMission(
                                            missionId: widget.mission?.id ?? 0,
                                            childrenId: childUserId ?? 0,
                                            name: _missionNameController.text
                                                .trim(),
                                            description:
                                                _noteController.text.trim(),
                                            reward: reward,
                                            punishment: punishment,
                                            periodeTime: timePeriodMap[
                                                selectedTimePeriodLabel]!,
                                            startDate: selectedStartDate
                                                .toIso8601String()
                                                .split('T')
                                                .first,
                                            endDate: selectedEndDate
                                                .toIso8601String()
                                                .split('T')
                                                .first,
                                            type: missionTypeMap[
                                                selectedMissionTypeLabel]!,
                                            condition: missionConditionMap[
                                                selectedConditionLabel]!,
                                            appCategory: appCategoryMap[
                                                selectedCategoryLabel]!,
                                            appName:
                                                _appNameController.text.trim(),
                                            directReward:
                                                _directRewardController.text
                                                    .trim(),
                                            directPunishment:
                                                _directPunishmentController.text
                                                    .trim(),
                                            pointAddition:
                                                reward != 0 ? reward : null,
                                            pointDeduction: punishment != 0
                                                ? punishment
                                                : null,
                                          ));
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side:
                                          const BorderSide(color: Colors.black),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 16),
                                      backgroundColor: whiteColor,
                                    ),
                                    child: Text(
                                      'Simpan',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 20.sp, fontWeight: bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 50.h),
                          ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<MissionBloc, MissionState>(
            builder: (context, state) {
              if (state is MissionLoading) {
                return Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const LoadingDialog(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
