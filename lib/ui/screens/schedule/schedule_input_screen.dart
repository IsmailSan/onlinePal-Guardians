import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:online_pal_guardians/models/schedule/schedule_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/schedule/child_schedule_screen.dart';
import 'package:online_pal_guardians/ui/screens/schedule/dialog/cupertino_duration_picker_dialog.dart';
import 'package:online_pal_guardians/ui/screens/schedule/dialog/cupertino_time_picker_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/dropdown_flexible_field.dart';
import 'package:online_pal_guardians/ui/widgets/custom_form_field.dart';
import 'package:online_pal_guardians/ui/widgets/dropdown_time_field.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:online_pal_guardians/ui/widgets/success_dialog.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class ScheduleInputScreen extends StatefulWidget {
  final bool? isEdit;
  final int? scheduleId;
  final Schedule? schedule;
  final String? suggestedSchedule;

  const ScheduleInputScreen(
      {Key? key,
      this.isEdit = false,
      this.scheduleId,
      this.schedule,
      this.suggestedSchedule})
      : super(key: key);

  @override
  State<ScheduleInputScreen> createState() => _ScheduleInputScreenState();
}

class _ScheduleInputScreenState extends State<ScheduleInputScreen> {
  late final TextEditingController nameController;
  late final TextEditingController noteController;
  DateTime selectedFirstDate = DateTime.now();
  DateTime? selectedEndDate;
  late TimeOfDay startTime;
  late TimeOfDay endTime;
  String repeat = 'once';
  int durationInMinutes = 60;
  ChildProfile? selectedProfile;
  int? childUserId;

  Future<void> _selectDate(BuildContext context) async {
    if (widget.isEdit == true) {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: widget.schedule?.date != null
            ? DateTime.parse(widget.schedule?.date ?? "")
            : DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (picked != null) {
        setState(() {
          selectedFirstDate = picked;
          selectedEndDate = null;
        });
      }
    } else {
      final DateTimeRange? picked = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        initialDateRange: selectedEndDate != null
            ? DateTimeRange(start: selectedFirstDate, end: selectedEndDate!)
            : null,
      );

      if (picked != null) {
        setState(() {
          selectedFirstDate = picked.start;
          selectedEndDate = picked.end;
        });
      }
    }
  }

  String dateToYMD(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  final Map<String, String> repeatOptions = {
    'once': 'Sekali saja (tidak berulang)',
    'every_weekday': 'Setiap hari biasa',
    'every_weekend': 'Setiap akhir pekan',
    'one_week': 'Setiap satu minggu',
    'one_month': 'Setiap satu bulan',
  };

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
        text: widget.schedule?.customName != null
            ? widget.schedule?.customName
            : widget.suggestedSchedule ?? '');
    noteController = TextEditingController(text: widget.schedule?.notes ?? '');
    final now = TimeOfDay.now();
    startTime = now;
    endTime = now;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
              width: double.infinity,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 60.h, right: 16, left: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Input/Edit Aktivitas",
                        style: blackTextStyle.copyWith(
                            fontSize: 24.sp, fontWeight: bold),
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
                  SizedBox(height: 60.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                  fontSize: 17.sp, fontWeight: bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Tanggal:',
                          style: blackTextStyle.copyWith(
                              fontSize: 20.sp, fontWeight: regular),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        flex: 7,
                        child: GestureDetector(
                          onTap: () => _selectDate(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(color: lightBlueColor)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedEndDate != null
                                      ? "${selectedFirstDate.day.toString().padLeft(2, '0')}/${selectedFirstDate.month.toString().padLeft(2, '0')}/${selectedFirstDate.year}"
                                          " - "
                                          "${selectedEndDate!.day.toString().padLeft(2, '0')}/${selectedEndDate!.month.toString().padLeft(2, '0')}/${selectedEndDate!.year}"
                                      : "${selectedFirstDate.day.toString().padLeft(2, '0')}/${selectedFirstDate.month.toString().padLeft(2, '0')}/${selectedFirstDate.year}",
                                  style:
                                      blackTextStyle.copyWith(fontSize: 16.sp),
                                ),
                                SizedBox(width: 8.w),
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
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Awal:',
                              style: blackTextStyle.copyWith(fontSize: 20.sp)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Akhir:',
                              style: blackTextStyle.copyWith(fontSize: 20.sp)),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Durasi:',
                              style: blackTextStyle.copyWith(fontSize: 20.sp)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TimeDropdownField(
                            time: startTime,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => CupertinoTimePickerDialog(
                                  initialHour: startTime.hour,
                                  initialMinute: startTime.minute,
                                  onTimeSelected: (newTime) {
                                    setState(() {
                                      startTime = newTime;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TimeDropdownField(
                            time: endTime,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => CupertinoTimePickerDialog(
                                  initialHour: endTime.hour,
                                  initialMinute: endTime.minute,
                                  onTimeSelected: (newTime) {
                                    setState(() {
                                      endTime = newTime;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        flex: 2,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: FlexibleDropdownField(
                            valueText: "$durationInMinutes Min",
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => CupertinoDurationPickerDialog(
                                  initialDuration: durationInMinutes,
                                  onDurationSelected: (newDuration) {
                                    setState(() {
                                      durationInMinutes = newDuration;
                                    });
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Nama:',
                            style: blackTextStyle.copyWith(
                                fontSize: 20.sp, fontWeight: regular),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: CustomFormField(
                          label: '',
                          hintText: '',
                          controller: nameController,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Catatan:',
                            style: blackTextStyle.copyWith(
                                fontSize: 20.sp, fontWeight: regular),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: CustomFormField(
                          label: '',
                          hintText: '',
                          controller: noteController,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          height: 60.h,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Ulangi:',
                            style: blackTextStyle.copyWith(
                                fontSize: 20.sp, fontWeight: regular),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          height: 60.h,
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey.shade300)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: repeat,
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  color: Colors.indigo),
                              style: blackTextStyle.copyWith(fontSize: 16.sp),
                              items: repeatOptions.entries.map((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key, // backend value
                                  child: Text(entry.value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  repeat = value!;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  Center(
                    child: BlocListener<ScheduleBloc, ScheduleState>(
                      listener: (context, state) {
                        if (state is CreateScheduleSuccess) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => SuccessDialog(
                              message: 'Aktivitas berhasil ditambahkan',
                              onOk: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChildScheduleScreen()),
                                );
                              },
                            ),
                          );
                        } else if (state is UpdateScheduleSuccess) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => SuccessDialog(
                              message: 'Aktivitas berhasil diperbarui',
                              onOk: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChildScheduleScreen()),
                                );
                              },
                            ),
                          );
                        } else if (state is ScheduleError) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) => ErrorDialog(message: state.message),
                          );
                        }
                      },
                      child: SizedBox(
                        width: 250.w,
                        height: 55.h,
                        child: OutlinedButton(
                          onPressed: () async {
                            print(
                                "${startTime.hour.toString().padLeft(2, '0')}${startTime.minute.toString().padLeft(2, '0')}");
                            final profile =
                                await SessionHelper().getChildProfile();
                            final childUserId = profile?.userId;

                            if (childUserId != null) {
                              context.read<ScheduleBloc>().add(
                                    widget.isEdit!
                                        ? UpdateSchedule(
                                            scheduleId: widget.scheduleId!,
                                            date: dateToYMD(selectedFirstDate),
                                            timeStart:
                                                "${startTime.hour.toString().padLeft(2, '0')}${startTime.minute.toString().padLeft(2, '0')}",
                                            timeEnd:
                                                "${endTime.hour.toString().padLeft(2, '0')}${endTime.minute.toString().padLeft(2, '0')}",
                                            scheduleItemId: null,
                                            customName: nameController.text,
                                            customCategory: '',
                                            customIcon: '',
                                            customColor: '',
                                          )
                                        : CreateSchedule(
                                            date: dateToYMD(selectedFirstDate),
                                            dateEnd: selectedEndDate != null
                                                ? dateToYMD(selectedEndDate!)
                                                : null,
                                            timeStart:
                                                "${startTime.hour.toString().padLeft(2, '0')}${startTime.minute.toString().padLeft(2, '0')}",
                                            timeEnd:
                                                "${endTime.hour.toString().padLeft(2, '0')}${endTime.minute.toString().padLeft(2, '0')}",
                                            scheduleItemId: null,
                                            customName: nameController.text,
                                            customCategory: '',
                                            customIcon: '',
                                            customColor: '',
                                            repeat: repeat,
                                            childrenId: childUserId,
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
                            backgroundColor: Colors.white,
                          ),
                          child: Text(
                            'Simpan',
                            style: blackTextStyle.copyWith(
                                fontSize: 18.sp, fontWeight: bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<ScheduleBloc, ScheduleState>(
            builder: (context, state) {
              if (state is ScheduleLoading) {
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
