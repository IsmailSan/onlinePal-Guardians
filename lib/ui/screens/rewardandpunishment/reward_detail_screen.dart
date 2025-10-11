import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/reward_punishment_bloc/reward_punishment_bloc.dart';
import 'package:online_pal_guardians/models/reward_punishment/active_reward_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/reward_history_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/create_reward_condition_screen.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/dialog/confirm_action_dialog.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/edit_reward_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/ui/widgets/success_dialog.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class RewardDetailScreen extends StatefulWidget {
  final String? status;
  const RewardDetailScreen({Key? key, this.status}) : super(key: key);

  @override
  State<RewardDetailScreen> createState() => _RewardDetailScreenState();
}

class _RewardDetailScreenState extends State<RewardDetailScreen> {
  List<RewardItem>? rewardList;
  List<RewardHistoryItem>? rewardHistoryList;
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
        context.read<RewardPunishmentBloc>().add(GetActiveRewardList(
              childrenId: childUserId,
            ));
      } else {
        context.read<RewardPunishmentBloc>().add(GetRewardHistoryList(
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
          context.read<RewardPunishmentBloc>().add(GetActiveRewardList(
                childrenId: childUserId,
              ));
        } else {
          context.read<RewardPunishmentBloc>().add(GetRewardHistoryList(
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
                      widget.status == "active"
                          ? "Kondisi Hadiah Aktif"
                          : "Riwayat Hadiah",
                      style: blackTextStyle.copyWith(
                          fontSize: 20.sp, fontWeight: bold, fontStyle: italic),
                    ),
                    Row(
                      children: [
                        ChildProfileSelector(
                          onProfileChanged: (profile) {
                            context
                                .read<RewardPunishmentBloc>()
                                .add(RewardPunishmentInitialized());

                            if (widget.status == "active") {
                              context
                                  .read<RewardPunishmentBloc>()
                                  .add(GetActiveRewardList(
                                    childrenId: profile.userId ?? 0,
                                  ));
                            } else {
                              context
                                  .read<RewardPunishmentBloc>()
                                  .add(GetRewardHistoryList(
                                    childrenId: profile.userId ?? 0,
                                  ));
                            }
                          },
                        ),
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
                    // Expanded(
                    //   child: Container(
                    //     height: 40.h,
                    //     padding: EdgeInsets.symmetric(horizontal: 12.w),
                    //     decoration: BoxDecoration(
                    //       color: Colors.grey.shade200,
                    //       borderRadius: BorderRadius.circular(5.w),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         const Icon(Icons.search, color: Colors.grey),
                    //         SizedBox(width: 10.w),
                    //         const Expanded(
                    //           child: TextField(
                    //             decoration: InputDecoration(
                    //               hintText: "Cari",
                    //               border: InputBorder.none,
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child:
                      BlocConsumer<RewardPunishmentBloc, RewardPunishmentState>(
                          listener: (context, state) {
                    if (state is RewardPunishmentError) {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => ErrorDialog(message: state.message),
                      );
                    } else if (state is DeleteRewardSuccess) {
                      final status = widget.status;

                      SessionHelper().getChildProfile().then((profile) {
                        final childUserId = profile?.userId;
                        if (childUserId != null) {
                          if (status == "active") {
                            context
                                .read<RewardPunishmentBloc>()
                                .add(GetActiveRewardList(
                                  childrenId: childUserId,
                                ));
                          } else {
                            context
                                .read<RewardPunishmentBloc>()
                                .add(GetRewardHistoryList(
                                  childrenId: childUserId,
                                ));
                          }
                        }
                      });
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => SuccessDialog(
                            message: 'Kondisi hadiah berhasil dihapus'),
                      );
                    } else if (state is ActiveRewardListLoaded &&
                        widget.status == "active") {
                      _isFetchingMore = false;
                      _nextCursor = state.response.data?.nextCursor;
                    } else if (state is RewardHistoryListLoaded &&
                        widget.status != "active") {
                      _isFetchingMore = false;
                      _nextCursor = state.response.data?.nextCursor;
                    }
                  }, builder: (context, state) {
                    final isActive = widget.status == 'active';

                    if (isActive && state is ActiveRewardListLoaded) {
                      rewardList = state.response.data?.data;
                    } else if (!isActive && state is RewardHistoryListLoaded) {
                      rewardHistoryList = state.response.data?.data;
                    }

                    final currentList =
                        isActive ? rewardList : rewardHistoryList;

                    if (currentList == null || currentList.isEmpty) {
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
                              isActive
                                  ? 'Hadiah aktif tidak tersedia'
                                  : 'Riwayat hadiah tidak tersedia',
                              style: blackTextStyle.copyWith(
                                fontSize: 16.sp,
                                fontWeight: bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    }

                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: currentList.length,
                      itemBuilder: (context, index) {
                        final reward = currentList[index];

                        final int id = isActive
                            ? (reward as RewardItem).id ?? 0
                            : (reward as RewardHistoryItem).id ?? 0;

                        final String name = isActive
                            ? (reward as RewardItem).name ?? ""
                            : (reward as RewardHistoryItem).name ?? "";

                        final String periodStartDate = isActive
                            ? (reward as RewardItem).periodStartDate ?? ""
                            : (reward as RewardHistoryItem).periodStartDate ??
                                "";

                        final String periodEndDate = isActive
                            ? (reward as RewardItem).periodEndDate ?? ""
                            : (reward as RewardHistoryItem).periodEndDate ?? "";

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${index + 1}.",
                                style: blackTextStyle.copyWith(fontSize: 15.sp),
                              ),
                              SizedBox(width: 8.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: blackTextStyle.copyWith(
                                          fontSize: 15.sp),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "waktu: $periodStartDate - $periodEndDate",
                                      style: blackTextStyle.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Divider(color: grayColor, height: 0.5),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditRewardScreen(
                                            status: isActive ? 'active' : '',
                                            reward: reward
                                                as RewardItem, // hanya RewardItem untuk active
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(13.w),
                                      decoration:
                                          BoxDecoration(color: purpleColor),
                                      child: Icon(Icons.settings,
                                          size: 18.sp, color: Colors.white),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => ConfirmActionDialog<
                                            RewardPunishmentBloc>(
                                          title:
                                              'Apakah Anda yakin ingin menghapus kondisi hadiah ini?',
                                          subtitle:
                                              'Notifikasi mengenai aksi ini akan dikirimkan ke perangkat anak.',
                                          primaryButtonText: 'Ya',
                                          primaryButtonTextColor: whiteColor,
                                          secondaryButtonText: 'Tidak',
                                          primaryButtonColor: redColor,
                                          secondaryButtonColor: whiteColor,
                                          onConfirmEvent:
                                              DeleteReward(rewardId: id),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(13.w),
                                      decoration: const BoxDecoration(
                                          color: Colors.red),
                                      child: Icon(Icons.delete,
                                          size: 18.sp, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
                if (widget.status == 'active')
                  Center(
                    child: SizedBox(
                      width: 300.w,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const CreateRewardConditionScreen()));
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                          backgroundColor: greenColor,
                        ),
                        child: Text(
                          'Buat kondisi hadiah baru',
                          style: blackTextStyle.copyWith(
                              fontSize: 20.sp, fontWeight: bold),
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 8.h),
              ],
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
        ],
      ),
    );
  }
}
