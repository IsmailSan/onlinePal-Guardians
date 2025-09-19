import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_event.dart';
import 'package:online_pal_guardians/bloc/reward_punishment_bloc/reward_punishment_bloc.dart';
import 'package:online_pal_guardians/models/reward_punishment/active_punishment_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/punishment_history_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/dialog/confirm_action_dialog.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/edit_punishment_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';


class PunishmentDetailScreen extends StatefulWidget {
  final String? status;
  const PunishmentDetailScreen({Key? key, this.status}) : super(key: key);

  @override
  State<PunishmentDetailScreen> createState() =>
      _PunishmentDetailScreenState();
}

class _PunishmentDetailScreenState extends State<PunishmentDetailScreen> {
  List<PunishmentItem>? punishmentList;
  List<PunishmentHistoryItem>? punishmentHistoryList;
  late ScrollController _scrollController;
  bool _isFetchingMore = false;
  int? _nextCursor;
  int? selectedProfileId;

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

    context.read<RewardPunishmentBloc>().add(RewardPunishmentInitialized());

    if (childUserId != null) {
      if (widget.status == "active") {
        context.read<RewardPunishmentBloc>().add(GetActivePunishmentList(
          childrenId: childUserId,
        ));
      } else {
        context.read<RewardPunishmentBloc>().add(GetPunishmentHistoryList(
          childrenId: childUserId,
        ));
      }
    }
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
        if (widget.status == "active") {
          context.read<RewardPunishmentBloc>().add(GetActivePunishmentList(
            childrenId: childUserId,
          ));
        } else {
          context.read<RewardPunishmentBloc>().add(GetPunishmentHistoryList(
            childrenId: childUserId,
          ));
        }
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.status == "active" ? "Kondisi Hukuman Aktif" : "Riwayat Hukuman",
                      style: blackTextStyle.copyWith(
                          fontSize: 20.sp, fontWeight: bold, fontStyle: italic),
                    ),
                    Row(
                      children: [
                        ChildProfileSelector(  onProfileChanged: (profile) {
                          context.read<MissionBloc>().add(MissionInitialized());
                          context.read<MissionBloc>().add(GetMissions(
                            childrenId: profile.userId,
                            status: widget.status ?? "",
                          ));
                        },),
                        SizedBox(width: 14.w),
                        MoreOptionsDropdown(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 60.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => {
                        Navigator.pop(context),
                      },

                      child: Row(
                        children: [
                          const Icon(Icons.arrow_back_ios,
                              size: 18.0, color: Colors.black),
                          SizedBox(width: 4.w),
                          Text(
                            'Kembali',
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Container(
                        height: 40.h,
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(5.w),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 10.w),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Cari",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: BlocConsumer<RewardPunishmentBloc, RewardPunishmentState>(
                    listener: (context, state) {
                      if (state is RewardPunishmentError) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => ErrorDialog(message: state.message),
                        );
                      } else if (state is ActivePunishmentListLoaded && widget.status == "active") {
                        _isFetchingMore = false;
                        _nextCursor = state.response.data.nextCursor;
                      } else if (state is PunishmentHistoryListLoaded && widget.status != "active") {
                        _isFetchingMore = false;
                        _nextCursor = state.response.data.nextCursor;
                      }
                    },
                    builder: (context, state) {
                      if (widget.status == "active" && state is ActivePunishmentListLoaded) {
                        punishmentList = state.response.data.data;
                      } else if (widget.status != "active" && state is PunishmentHistoryListLoaded) {
                        punishmentHistoryList = state.response.data.data;
                      }
                      if (punishmentList == null || punishmentList!.isEmpty ||  punishmentHistoryList == null || punishmentHistoryList!.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/no_data.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                widget.status == "active" ? 'Hadiah aktif tidak tersedia' : 'Riwayat hadia tidak tersedia',
                                style: blackTextStyle.copyWith(fontSize: 16.sp, fontWeight: bold),
                              ),
                            ],
                          ),
                        );
                      }
                      if (punishmentList != null || punishmentHistoryList != null) {
                        return ListView.builder(
                          controller: _scrollController,
                          itemCount: widget.status == 'active' ? punishmentList?.length : punishmentHistoryList?.length,
                          itemBuilder: (context, index) {
                            final isActive = widget.status == 'active';
                            final activeList = isActive ? punishmentList : punishmentHistoryList;

                            if (activeList == null || index >= activeList.length) {
                              return const SizedBox.shrink();
                            }

                            final punishment = activeList[index];

                            final int id = isActive
                                ? (punishment as PunishmentItem).id
                                : (punishment as PunishmentHistoryItem).id;

                            final String name = isActive
                                ? (punishment as PunishmentItem).name
                                : (punishment as PunishmentHistoryItem).name;

                            final String period = isActive
                                ? (punishment as PunishmentItem).periodStartDate
                                : (punishment as PunishmentHistoryItem).periodStartDate;
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index + 1}.",
                                    style: blackTextStyle.copyWith(
                                        fontSize: 15.sp),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          style: blackTextStyle.copyWith(
                                              fontSize: 15.sp),
                                        ),
                                        SizedBox(height: 4.h),
                                        Text(
                                          "Periode: ${period}",
                                          style: blackTextStyle.copyWith(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        Divider(
                                            color: Colors.black,
                                            height: 0.5),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Row(
                                      children:  [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        EditPunishmentScreen(punishment: (punishment as PunishmentItem),)));
                                          },
                                          child: Container(
                                            padding:
                                            EdgeInsets.all(13.w),
                                            decoration: BoxDecoration(
                                                color: purpleColor),
                                            child: Icon(Icons.settings,
                                                size: 18.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (_) => ConfirmActionDialog<RewardPunishmentBloc>(
                                                title: 'Apakah Anda yakin ingin menghapus kondisi hukuman ini?',
                                                subtitle: 'Notifikasi mengenai aksi ini akan dikirimkan ke perangkat anak.',
                                                primaryButtonText: 'Ya',
                                                primaryButtonTextColor: whiteColor,
                                                secondaryButtonText: 'Tidak',
                                                primaryButtonColor: redColor,
                                                secondaryButtonColor: whiteColor,
                                                onConfirmEvent: DeletePunishment(
                                                    punishmentId: id),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding:
                                            EdgeInsets.all(13.w),
                                            decoration:
                                            const BoxDecoration(
                                                color: Colors.red),
                                            child: Icon(Icons.delete,
                                                size: 18.sp,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ]
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }

                      return const Center();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
