import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_event.dart';
import 'package:online_pal_guardians/bloc/reward_punishment_bloc/reward_punishment_bloc.dart';
import 'package:online_pal_guardians/models/reward_punishment/punishment_history_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/reward_punishment_screen.dart';
import 'package:online_pal_guardians/ui/widgets/custom_form_field.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/ui/widgets/success_dialog.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dialog/confirm_action_dialog.dart';


class PunishmentHistoryScreen extends StatefulWidget {
  final PunishmentHistoryItem? punishment;
  final String? status;

  const PunishmentHistoryScreen({Key? key, this.status, this.punishment})
      : super(key: key);

  @override
  State<PunishmentHistoryScreen> createState() => _PunishmentHistoryScreenState();
}

class _PunishmentHistoryScreenState extends State<PunishmentHistoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pointController = TextEditingController();
  final TextEditingController _missionController = TextEditingController();
  final TextEditingController _rewardAssignedTimeController =
  TextEditingController();
  final TextEditingController _exchangedPointsController =
  TextEditingController();
  final TextEditingController _missionSuccessCountController =
  TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  late final PunishmentHistoryItem? _historyPunishment;

  late DateTime _initialStartDate;
  late DateTime _initialEndDate;
  int? selectedMissionId;
  String? _nextCursor;
  bool _isFetchingMore = false;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    final profile = await SessionHelper().getChildProfile();
    final childUserId = profile?.userId;
    context.read<MissionBloc>().add(MissionInitialized());
    if (childUserId != null) {
      context.read<MissionBloc>().add(GetMissions(
        childrenId: childUserId,
        status: "active",
      ));
    }

    _historyPunishment = widget.punishment;
    _initialStartDate = DateTime.parse(
        _historyPunishment?.periodStartDate ?? DateTime.now().toIso8601String());
    _initialEndDate = DateTime.parse(
        _historyPunishment?.periodEndDate ?? DateTime.now().toIso8601String());
    _pointController.text = _historyPunishment?.pointsNeeded ?? "";
    _noteController.text = _historyPunishment?.description ?? "";
    _missionSuccessCountController.text = _historyPunishment?.qtyCondition.toString() ?? "";
    _missionController.text = _historyPunishment?.mission?.name  ?? "";
    _rewardAssignedTimeController.text = _historyPunishment?.createdAt  ?? "";
    _exchangedPointsController.text = _historyPunishment?.pointsNeeded  ?? "";
    selectedStartDate = _initialStartDate;
    selectedEndDate = _initialEndDate;
  }

  void _onScroll() async {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100 &&
        !_isFetchingMore &&
        _nextCursor != null) {
      setState(() {
        _isFetchingMore = true;
      });

      final profile = await SessionHelper().getChildProfile();
      final childUserId = profile?.userId;

      if (childUserId != null) {
        context.read<MissionBloc>().add(GetMissions(
          childrenId: childUserId,
          status: "active",
          cursor: _nextCursor,
          isRefresh: false,
        ));
      }
    }
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final today = DateTime.now();
    final todayDateOnly = DateTime(today.year, today.month, today.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
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
      initialDate: selectedEndDate,
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
                        "Kondisi Hadiah Aktif",
                        style: blackTextStyle.copyWith(
                            fontSize: 20.sp,
                            fontWeight: bold,
                            fontStyle: italic),
                      ),
                      Row(
                        children: [
                          // ChildProfileSelector(),
                          SizedBox(width: 14.w),
                          MoreOptionsDropdown(),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 60.h),
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
                                _historyPunishment?.name ?? "",
                                style: blackTextStyle.copyWith(
                                  fontSize: 18.sp,
                                  fontWeight: medium,
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Periode Hadiah Berlaku",
                              style: blackTextStyle.copyWith(
                                  fontSize: 18.sp, fontWeight: medium),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
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
                                        style: widget.status == "active"
                                            ? blackTextStyle.copyWith(
                                            fontSize: 16.sp)
                                            : grayTextStyle.copyWith(
                                            fontSize: 16.sp),
                                      ),
                                      SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Text("-",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16.sp)),
                                ),
                                Container(
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
                                        "${selectedEndDate.day.toString().padLeft(2, '0')}/${selectedEndDate.month.toString().padLeft(2, '0')}/${selectedEndDate.year}",
                                        style:  grayTextStyle.copyWith(
                                            fontSize: 16.sp),
                                      ),
                                      SizedBox.shrink(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Waktu Penetapan Hadiah",
                              style: blackTextStyle.copyWith(
                                  fontSize: 18.sp, fontWeight: medium),
                            ),
                            SizedBox(height: 20.h),
                            CustomFormField(
                              label: '',
                              hintText: '',
                              controller: _rewardAssignedTimeController,
                              readOnly: true,
                              isShowLabel: false,
                            ),

                            (_historyPunishment?.type == 'mission')
                                ? Column(
                              children: [
                                Text(
                                  "Misi",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 18.sp, fontWeight: medium),
                                ),
                                SizedBox(height: 20.h),
                                CustomFormField(
                                  label: '',
                                  hintText: '',
                                  controller: _missionController,
                                  readOnly: true,
                                  isShowLabel: false,
                                ),
                              ],
                            )
                                : Column(
                              children: [
                                Text(
                                  "Poin yang Ditukar",
                                  style: blackTextStyle.copyWith(
                                      fontSize: 18.sp, fontWeight: medium),
                                ),
                                SizedBox(height: 20.h),
                                CustomFormField(
                                  label: '',
                                  hintText: '',
                                  controller: _exchangedPointsController,
                                  readOnly: true,
                                  isShowLabel: false,
                                ),
                              ],
                            ),

                            Text(
                              "Catatan",
                              style: blackTextStyle.copyWith(
                                  fontSize: 18.sp, fontWeight: medium),
                            ),
                            SizedBox(height: 20.h),
                            CustomFormField(
                              label: '',
                              hintText: '',
                              controller: _noteController,
                              readOnly: true,
                              isShowLabel: false,
                              minLines: 1,
                              maxLines: null,
                            ),
                            SizedBox(height: 50.h),
                            BlocListener<RewardPunishmentBloc, RewardPunishmentState>(
                              listener: (context, state) {
                                if (state is ConfirmPunishmentSuccess) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => SuccessDialog(message: 'Hukuman berhasil ditandai sebagai selesai', onOk: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(builder: (context) => const RewardPunishmentScreen()),
                                      );
                                    }),
                                  );
                                } else if (state is RewardPunishmentError) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (_) => ErrorDialog(message: state.message),
                                  );
                                }
                              },
                              child: Center(
                                child: SizedBox(
                                  width: 300.w,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) =>
                                            ConfirmActionDialog<RewardPunishmentBloc>(
                                              title: 'Apakah Anda yakin ingin menandai hukuman ini sebagai "selesai"?',
                                              subtitle:
                                              'Notifikasi mengenai aksi ini akan dikirimkan ke perangkat anak.',
                                              primaryButtonText: 'Ya',
                                              primaryButtonTextColor: blackColor,
                                              secondaryButtonText: 'Tidak',
                                              primaryButtonColor: greenColor,
                                              secondaryButtonColor: whiteColor,
                                              onConfirmEvent:
                                              ConfirmPunishment(punishmentId: widget.punishment?.id ?? 0),
                                            ),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      side:
                                      const BorderSide(color: Colors.black),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16, horizontal: 16),
                                      backgroundColor:  greenColor,
                                    ),
                                    child: Text(
                                      'Konfirmasi pemberian hadiah',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 20.sp, fontWeight: bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 30.h),
                            Center(
                              child: SizedBox(
                                width: 300.w,
                                child: OutlinedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) =>
                                          ConfirmActionDialog<RewardPunishmentBloc>(
                                            title:'Apakah Anda yakin ingin menghapus  hadiah ini?',
                                            subtitle:
                                            'Notifikasi mengenai aksi ini akan dikirimkan ke perangkat anak.',
                                            primaryButtonText: 'Ya',
                                            primaryButtonTextColor: whiteColor,
                                            secondaryButtonText: 'Tidak',
                                            primaryButtonColor: redColor,
                                            secondaryButtonColor: whiteColor,
                                            onConfirmEvent:
                                            DeletePunishment(punishmentId: widget.punishment?.id ?? 0),
                                          ),
                                    );
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side:
                                    const BorderSide(color: Colors.black),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 16),
                                    backgroundColor: redColor,
                                  ),
                                  child: Text(
                                    'Hapus Hadiah',
                                    style: whiteTextStyle.copyWith(
                                        fontSize: 20.sp, fontWeight: bold),
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
        ],
      ),
    );
  }
}
