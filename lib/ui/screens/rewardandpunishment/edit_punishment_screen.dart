import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_event.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_state.dart';
import 'package:online_pal_guardians/bloc/reward_punishment_bloc/reward_punishment_bloc.dart';
import 'package:online_pal_guardians/models/mission/mission_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/active_punishment_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/modal/mission_selector_modal.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/reward_punishment_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/custom_form_field.dart';
import 'package:online_pal_guardians/ui/widgets/dropdown_list_field.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/ui/widgets/point_selector_field.dart';
import 'package:flutter/gestures.dart';
import 'package:online_pal_guardians/ui/widgets/success_dialog.dart';
import 'package:online_pal_guardians/utils/date_helper.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dialog/confirm_action_dialog.dart';

class EditPunishmentScreen extends StatefulWidget {
  final PunishmentItem? punishment;
  const EditPunishmentScreen({Key? key, this.punishment}) : super(key: key);

  @override
  State<EditPunishmentScreen> createState() => _EditPunishmentScreenState();
}

class _EditPunishmentScreenState extends State<EditPunishmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pointReductionController =
      TextEditingController();
  final TextEditingController _punishmentController = TextEditingController();
  final TextEditingController _missionSuccessCountController =
      TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime selectedStartDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String missionConditionLabel = 'Setiap Kali Misi Gagal';
  bool isReductionChecked = false;
  bool isPunishmentChecked = false;
  Mission? selectedMission;
  List<Mission> missions = [];
  int? selectedMissionId;
  String? _nextCursor;
  bool _isFetchingMore = false;
  late ScrollController _scrollController;
  late final PunishmentItem? _activePunishment;
  late DateTime _initialStartDate;
  late DateTime _initialEndDate;

  String get missionConditionValue =>
      missionConditionMap[missionConditionLabel] ?? 'each_time';

  final Map<String, String> missionConditionMap = {
    'Setiap Kali Misi Gagal': 'each_time',
    'Frekuensi Misi Gagal Dilakukan': 'time_frequency',
    'Misi Gagal Berturut-turut selama': 'time_streak',
  };

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

    _activePunishment = widget.punishment;
    _initialStartDate = DateTime.parse(
        _activePunishment?.periodStartDate ?? DateTime.now().toIso8601String());
    _initialEndDate = DateTime.parse(
        _activePunishment?.periodEndDate ?? DateTime.now().toIso8601String());
    _pointReductionController.text =
        _activePunishment?.pointReduction.toString() ?? "";
    _noteController.text = _activePunishment?.description ?? "";
    _missionSuccessCountController.text =
        _activePunishment?.qtyCondition.toString() ?? "";
    final matchedEntry = missionConditionMap.entries.firstWhere(
      (entry) => entry.value == _activePunishment?.condition,
      orElse: () => const MapEntry('Setiap Kali Misi Gagal', 'each_time'),
    );
    missionConditionLabel = matchedEntry.key;
    selectedMissionId = _activePunishment?.mission?.id;
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
                        "Buat Kondisi Hukuman",
                        style: blackTextStyle.copyWith(
                            fontSize: 20.sp,
                            fontWeight: bold,
                            fontStyle: italic),
                      ),
                      Row(
                        children: [
                          ChildProfileSelector(
                            onProfileChanged: (profile) {
                              context
                                  .read<MissionBloc>()
                                  .add(MissionInitialized());
                              context.read<MissionBloc>().add(GetMissions(
                                    childrenId: profile.userId ?? 0,
                                    status: "active",
                                  ));
                            },
                          ),
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
                  BlocListener<MissionBloc, MissionState>(
                    listener: (context, state) {
                      if (state is MissionListSuccess) {
                        setState(() {
                          missions =
                              state.missionsByStatus["active"]?.data?.data ??
                                  [];
                          _nextCursor = state
                              .missionsByStatus["active"]?.data?.nextCursor
                              ?.toString();
                          _isFetchingMore = false;
                        });
                      } else if (state is MissionError) {
                        setState(() {
                          _isFetchingMore = false;
                        });
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => ErrorDialog(message: state.message),
                        );
                      }
                    },
                    child: Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Input Kondisi Hukuman Baru",
                                  style: blackTextStyle.copyWith(
                                    fontSize: 18.sp,
                                    fontWeight: medium,
                                  ),
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Text(
                                "Misi yang Menjadi Syarat Hukuman",
                                style: blackTextStyle.copyWith(
                                    fontSize: 18.sp, fontWeight: medium),
                              ),
                              SizedBox(height: 20.h),
                              GestureDetector(
                                onTap: () {
                                  showPaginatedMissionSelector(
                                    context: context,
                                    missions: missions,
                                    scrollController: _scrollController,
                                    isFetchingMore: _isFetchingMore,
                                    onSelected: (mission) {
                                      setState(() {
                                        selectedMission = mission;
                                        selectedMissionId = mission.id;
                                      });
                                    },
                                  );
                                },
                                child: DropdownListField(
                                  value: selectedMissionId != null
                                      ? selectedMissionId.toString()
                                      : null,
                                  hintText: 'Pilih Misi',
                                  enabled: false,
                                  items: selectedMission != null
                                      ? [
                                          {
                                            'label':
                                                selectedMission!.name ?? "",
                                            'value':
                                                selectedMissionId!.toString()
                                          }
                                        ]
                                      : [],
                                  onChanged: (_) {},
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return 'Pilih salah satu misi';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "Periode Hukuman Berlaku",
                                style: blackTextStyle.copyWith(
                                    fontSize: 18.sp, fontWeight: medium),
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              SizedBox(height: 20.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kondisi",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 18.sp, fontWeight: medium),
                                  ),
                                  SizedBox(height: 20.h),
                                  Container(
                                    height: 60.h,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.w),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: lightBlueColor)),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        isExpanded: true,
                                        value: missionConditionLabel,
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down,
                                            color: Colors.indigo),
                                        style: blackTextStyle.copyWith(
                                            fontSize: 16.sp),
                                        items: [
                                          'Setiap Kali Misi Gagal',
                                          'Frekuensi Misi Gagal Dilakukan',
                                          'Misi Gagal Berturut-turut selama',
                                        ].map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            missionConditionLabel = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  if (missionConditionLabel ==
                                          'Frekuensi Misi Gagal Dilakukan' ||
                                      missionConditionLabel ==
                                          'Misi Gagal Berturut-turut selama') ...[
                                    Column(
                                      children: [
                                        SizedBox(height: 20.h),
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 7,
                                              child: CustomFormField(
                                                label: '',
                                                hintText: '',
                                                controller:
                                                    _missionSuccessCountController,
                                                readOnly: false,
                                                isShowLabel: false,
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty) {
                                                    return 'Harus diisi';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(width: 20.h),
                                            Expanded(
                                              flex: 3,
                                              child: Text(
                                                "Kali",
                                                style: blackTextStyle.copyWith(
                                                    fontSize: 18.sp,
                                                    fontWeight: medium),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                  SizedBox(height: 20.h),
                                ],
                              ),
                              Row(
                                children: [
                                  Checkbox(
                                    value: isReductionChecked,
                                    activeColor: whiteColor,
                                    // warna latar saat dicentang
                                    checkColor: strongPurpleColor,
                                    // warna ikon centang
                                    fillColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                            (states) {
                                      return states
                                              .contains(WidgetState.selected)
                                          ? Colors.white
                                          : Colors.white;
                                    }),
                                    side: WidgetStateBorderSide.resolveWith(
                                        (states) {
                                      return BorderSide(
                                        color: states
                                                .contains(WidgetState.selected)
                                            ? Colors
                                                .black // border saat dicentang
                                            : Colors.black,
                                        // border saat belum dicentang
                                        width: 2,
                                      );
                                    }),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity(
                                        horizontal: -4.0, vertical: -4.0),
                                    onChanged: (value) {
                                      setState(() {
                                        isReductionChecked = value!;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 10.h),
                                  Text(
                                    "Reduksi Poin",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 18.sp, fontWeight: medium),
                                  ),
                                ],
                              ),
                              if (isReductionChecked)
                                Column(
                                  children: [
                                    Text(
                                      "Masukan nilai pengurangan poin setiap kali kondisi terjadi",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: medium,
                                          fontStyle: italic),
                                    ),
                                    PointSelectorField(
                                        controller: _pointReductionController),
                                  ],
                                ),
                              SizedBox(height: 20.h),
                              Row(
                                children: [
                                  // Checkbox(
                                  //   value: isPunishmentChecked,
                                  //   activeColor: whiteColor,
                                  //   checkColor: strongPurpleColor,
                                  //   fillColor:
                                  //       MaterialStateProperty.resolveWith<Color>(
                                  //           (states) {
                                  //     return states
                                  //             .contains(MaterialState.selected)
                                  //         ? Colors.white
                                  //         : Colors.white;
                                  //   }),
                                  //   side: MaterialStateBorderSide.resolveWith(
                                  //       (states) {
                                  //     return BorderSide(
                                  //       color: states
                                  //               .contains(MaterialState.selected)
                                  //           ? Colors.black
                                  //           : Colors.black,
                                  //       width: 2,
                                  //     );
                                  //   }),
                                  //   materialTapTargetSize:
                                  //       MaterialTapTargetSize.shrinkWrap,
                                  //   visualDensity: VisualDensity(
                                  //       horizontal: -4.0, vertical: -4.0),
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       isPunishmentChecked = value!;
                                  //     });
                                  //   },
                                  // ),
                                  Text(
                                    "Hukuman",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 18.sp, fontWeight: medium),
                                  ),
                                ],
                              ),
                              Text(
                                "Silahkan tuliskan hukuman yang ingin diberikan",
                                style: blackTextStyle.copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: medium,
                                    fontStyle: italic),
                              ),
                              CustomFormField(
                                label: '',
                                hintText: '',
                                controller: _punishmentController,
                                readOnly: false,
                                isShowLabel: false,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return 'Nama hukuman wajib diisi';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10.h),
                              Visibility(
                                visible: false,
                                child: RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "Bingung mengenai bentuk/jenis hukuman untuk diberikan?\n",
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: medium,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                          color: purpleColor, // agar mirip link
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print("Teks 1 diklik");
                                          },
                                      ),
                                      TextSpan(
                                        text:
                                            "Klik disini untuk melihat inspirasi hadiah/hukuman dari kami!",
                                        style: blackTextStyle.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: medium,
                                          fontStyle: FontStyle.italic,
                                          decoration: TextDecoration.underline,
                                          color: purpleColor,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            print("Teks 2 diklik");
                                          },
                                      ),
                                    ],
                                  ),
                                ),
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
                              BlocListener<RewardPunishmentBloc,
                                  RewardPunishmentState>(
                                listener: (context, state) {
                                  if (state is UpdatePunishmentSuccess) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => SuccessDialog(
                                          message:
                                              'Kondisi hukuman berhasil diperbarui',
                                          onOk: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RewardPunishmentScreen()),
                                            );
                                          }),
                                    );
                                  } else if (state is UpdatePunishmentError) {
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
                                    width: 300.w,
                                    child: OutlinedButton(
                                      onPressed: () async {
                                        if (_formKey.currentState?.validate() !=
                                            true) {
                                          return;
                                        }
                                        final profile = await SessionHelper()
                                            .getChildProfile();
                                        final childUserId = profile?.userId;

                                        if (childUserId != null) {
                                          showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  ConfirmActionDialog<
                                                      RewardPunishmentBloc>(
                                                    title:
                                                        'Apakah Anda yakin ingin membuat kondisi hukuman ini?',
                                                    subtitle:
                                                        'Notifikasi mengenai aksi ini akan dikirimkan ke perangkat anak.',
                                                    primaryButtonText: 'Ya',
                                                    primaryButtonTextColor:
                                                        blackColor,
                                                    secondaryButtonText:
                                                        'Tidak',
                                                    primaryButtonColor:
                                                        greenColor,
                                                    secondaryButtonColor:
                                                        whiteColor,
                                                    onConfirmEvent:
                                                        UpdatePunishment(
                                                      missionId:
                                                          selectedMissionId ??
                                                              0,
                                                      childrenId: childUserId,
                                                      name:
                                                          _punishmentController
                                                              .text,
                                                      description:
                                                          _noteController.text,
                                                      pointReduction:
                                                          _pointReductionController
                                                              .text,
                                                      periodStartDate: dateToYMD(
                                                          selectedStartDate),
                                                      periodEndDate: dateToYMD(
                                                          selectedEndDate),
                                                      condition:
                                                          missionConditionValue,
                                                      frequencyCount:
                                                          _missionSuccessCountController
                                                              .text,
                                                      punishmentId:
                                                          _activePunishment
                                                                  ?.id ??
                                                              0,
                                                    ),
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
                              SizedBox(height: 30.h),
                              BlocListener<RewardPunishmentBloc,
                                  RewardPunishmentState>(
                                listener: (context, state) {
                                  if (state is DeletePunishmentSuccess) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (_) => SuccessDialog(
                                          message:
                                              'Kondisi hukuman berhasil dihapus',
                                          onOk: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RewardPunishmentScreen()),
                                            );
                                          }),
                                    );
                                  } else if (state is DeletePunishmentError) {
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
                                    width: 300.w,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => ConfirmActionDialog<
                                              RewardPunishmentBloc>(
                                            title:
                                                'Apakah Anda yakin ingin menghapus hukuman ini?',
                                            subtitle:
                                                'Notifikasi mengenai aksi ini akan dikirimkan ke perangkat anak.',
                                            primaryButtonText: 'Ya',
                                            primaryButtonTextColor: whiteColor,
                                            secondaryButtonText: 'Tidak',
                                            primaryButtonColor: redColor,
                                            secondaryButtonColor: whiteColor,
                                            onConfirmEvent: DeleteReward(
                                                rewardId:
                                                    _activePunishment?.id ?? 0),
                                          ),
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                            color: Colors.black),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
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
                              ),
                              SizedBox(height: 30.h),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<RewardPunishmentBloc, RewardPunishmentState>(
            builder: (context, state) {
              if (state is RewardPunishmentLoading) {
                return Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const LoadingDialog(),
                );
              }
              return const SizedBox.shrink();
            },
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
