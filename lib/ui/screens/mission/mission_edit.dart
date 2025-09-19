import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/custom_form_field.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';

class MissionEditScreen extends StatefulWidget {
  final Mission? mission;
  const MissionEditScreen({Key? key , this.mission}) : super(key: key);

  @override
  State<MissionEditScreen> createState() => _MissionEditScreenState();
}

class _MissionEditScreenState extends State<MissionEditScreen> {
  final typeConditionController = TextEditingController(text: '');
  final specificConditionController = TextEditingController(text: '');
  final categoryController = TextEditingController(text: '');
  final appNameController = TextEditingController(text: '');
  final periodController = TextEditingController(text: '');
  final missionCreationTimeController = TextEditingController(text: '');
  final dailyPointsController = TextEditingController(text: '');
  final rewardController = TextEditingController(text: '');
  final penaltyController = TextEditingController(text: '');
  final dailyPointReductionController = TextEditingController(text: '');
  final notesController = TextEditingController(text: '');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    final mission = widget.mission ?? (args is Mission ? args : null);
    typeConditionController.text = mission?.type ?? '';
    specificConditionController.text = mission?.condition ?? '';
    appNameController.text = mission?.appName ?? '';
    periodController.text = mission?.periodeTime ?? '';
    if (mission?.createdAt != null) {
      DateTime parsed = DateTime.parse(mission!.createdAt.toString());

      String formatted = '${parsed.day.toString().padLeft(2, '0')}-'
          '${parsed.month.toString().padLeft(2, '0')}-'
          '${parsed.year} '
          '${parsed.hour.toString().padLeft(2, '0')}:'
          '${parsed.minute.toString().padLeft(2, '0')}';

      missionCreationTimeController.text = formatted;
    } else {
      missionCreationTimeController.text = '';
    }

    categoryController.text = mission?.appCategory ?? '';
  }

  @override
  void dispose() {
    typeConditionController.dispose();
    specificConditionController.dispose();
    categoryController.dispose();
    appNameController.dispose();
    periodController.dispose();
    missionCreationTimeController.dispose();
    dailyPointsController.dispose();
    rewardController.dispose();
    penaltyController.dispose();
    dailyPointReductionController.dispose();
    notesController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
    });
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Edit Misi",
                      style: blackTextStyle.copyWith(
                          fontSize: 20.sp, fontWeight: bold, fontStyle: italic),
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
                SizedBox(height: 37.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              widget.mission?.name ?? "",
                              style: blackTextStyle.copyWith(
                                  fontSize: 20.sp, fontWeight: medium),
                            ),
                            SizedBox(height: 33.h),
                            CustomFormField(
                              label: 'Tipe Misi',
                              hintText: '',
                              controller: typeConditionController,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Kondisi Khusus',
                              hintText: '',
                              controller: specificConditionController,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Kategori Aplikasi',
                              hintText: '',
                              controller: categoryController,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Nama Aplikasi',
                              hintText: '',
                              controller: appNameController,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Periode Waktu',
                              hintText: '',
                              controller: periodController,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Waktu Pembuatan Misi',
                              hintText: '',
                              controller: missionCreationTimeController,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Poin per Hari dari Misi Ini',
                              hintText: '',
                              controller: dailyPointsController,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Hadiah Langsung dari Misi Ini',
                              hintText: '-',
                              controller: rewardController,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Hukuman Langsung dari Misi Ini',
                              hintText: '-',
                              controller: penaltyController,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Pengurangan Poin Per Hari dari Misi Ini',
                              hintText: '-',
                              controller: dailyPointReductionController,
                            ),
                            SizedBox(height: 25.h),
                            CustomFormField(
                              label: 'Catatan',
                              hintText: '-',
                              controller: notesController,
                            ),
                            SizedBox(height: 25.h),
                            // OutlinedButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (context) =>
                            //                 const CreateNewSuggestedMissionScreen()));
                            //   },
                            //   style: OutlinedButton.styleFrom(
                            //     side: const BorderSide(color: Colors.black),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8),
                            //     ),
                            //     padding: const EdgeInsets.symmetric(
                            //         vertical: 16, horizontal: 16),
                            //     backgroundColor: greenColor,
                            //   ),
                            //   child: Text(
                            //     'Simpan',
                            //     style: blackTextStyle.copyWith(
                            //         fontSize: 20.sp, fontWeight: bold),
                            //   ),
                            // ),
                            SizedBox(height: 55.h),
                          ],
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
