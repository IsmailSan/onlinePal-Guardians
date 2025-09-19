import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:online_pal_guardians/bloc/reward_punishment_bloc/reward_punishment_bloc.dart';
import 'package:online_pal_guardians/models/reward_punishment/active_punishment_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/active_reward_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/punishment_history_list_response.dart';
import 'package:online_pal_guardians/models/reward_punishment/reward_history_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/create_punishment_condition_screen.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/dialog/new_reward_punishment_dialog.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/create_reward_condition_screen.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/edit_punishment_screen.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/edit_reward_screen.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/punishment_detail_screen.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/punishment_history_screen.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/reward_detail_screen.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/reward_history_screen.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/utils/session_helper.dart';

class RewardPunishmentScreen extends StatefulWidget {
  const RewardPunishmentScreen({Key? key}) : super(key: key);

  @override
  State<RewardPunishmentScreen> createState() => _RewardPunishmentScreenState();
}

class _RewardPunishmentScreenState extends State<RewardPunishmentScreen> {
  final List<Map<String, dynamic>> rewardLista = [
    {
      "title":
          "Bermain sepak bola pulang sekolah selama satu minggu berturut-turut.",
      "periode": "10/04/2024 - 17/04/2024",
      "point": "20 Poin",
    },
    {
      "title": "Aku boleh memilih menu makan sendiri selama seminggu penuh",
      "periode": "01/04/2024 - 07/04/2024",
      "point": "10 Poin",
    },
    {
      "title": "Hadiah kejutan dari orang tuamu",
      "periode": "03/04/2024 - 11/04/2024",
      "point": "15 Poin",
    },
    {
      "title": "Main ke taman bermain bersama keluarga",
      "periode": "15/04/2024 - 20/04/2024",
      "point": "25 Poin",
    },
  ];
  List<RewardItem>? rewardList;
  List<RewardHistoryItem>? rewardHistoryList;
  List<PunishmentItem>? punishmentList;
  List<PunishmentHistoryItem>? punishmentHistoryList;
  bool _hasLoadedData = false;

  DateTime getStartOfWeek(DateTime date) {
    int diff = date.weekday - DateTime.monday;
    return date.subtract(Duration(days: diff));
  }

  List<String> getIndonesianWeekLabels(DateTime startOfWeek) {
    const dayNames = ['Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab', 'Min'];
    return List.generate(7, (i) {
      final date = startOfWeek.add(Duration(days: i));
      return '${dayNames[date.weekday - 1]}\n${date.day}';
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final profile = await SessionHelper().getChildProfile();
      final childUserId = profile?.userId;

      context.read<RewardPunishmentBloc>().add(RewardPunishmentInitialized());

      if(
          childUserId != null) {
      context.read<RewardPunishmentBloc>().add(GetActiveRewardList(childrenId: childUserId));

        context
            .read<RewardPunishmentBloc>()
            .add(GetRewardHistoryList(
          childrenId: childUserId,
        ));
        context
            .read<RewardPunishmentBloc>()
            .add(GetActivePunishmentList(
          childrenId: childUserId,
        ));
        context
            .read<RewardPunishmentBloc>()
            .add(GetPunishmentHistoryList(
          childrenId: childUserId,
        ));
        }
      _hasLoadedData = true;
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
                      "Hadiah dan Hukuman",
                      style: blackTextStyle.copyWith(
                          fontSize: 20.sp, fontWeight: bold, fontStyle: italic),
                    ),
                    Row(
                      children: [
                        ChildProfileSelector(
                          onProfileChanged: (profile) {
                            // context
                            //     .read<RewardPunishmentBloc>()
                            //     .add(RewardPunishmentInitialized());
                            // context
                            //     .read<RewardPunishmentBloc>()
                            //     .add(GetActiveRewardList(
                            //       childrenId: profile.id,
                            //     ));
                            // context
                            //     .read<RewardPunishmentBloc>()
                            //     .add(GetRewardHistoryList(
                            //       childrenId: profile.id,
                            //     ));
                            // context
                            //     .read<RewardPunishmentBloc>()
                            //     .add(GetActivePunishmentList(
                            //       childrenId: profile.id,
                            //     ));
                            // context
                            //     .read<RewardPunishmentBloc>()
                            //     .add(GetPunishmentHistoryList(
                            //       childrenId: profile.id,
                            //     ));
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Center(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  NewRewardPunishmentDialog.show(context),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [softBlueColor, purpleColor],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "Bagaimana cara membuat hadiah dan hukuman?",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 12.sp, fontWeight: bold),
                                    ),
                                    SizedBox(height: 4.h),
                                    SvgPicture.asset(
                                      'assets/triangle_circle.svg',
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              width: double.infinity,
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: greenColor,
                                ),
                                child: Text(
                                  'Buat kondisi hadiah baru',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 20.sp, fontWeight: bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 18.h),
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreatePunishmentConditionScreen()));
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.black),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  backgroundColor: redColor,
                                ),
                                child: Text(
                                  'Buat kondisi hukuman baru',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 20.sp, fontWeight: bold),
                                ),
                              ),
                            ),
                            SizedBox(height: 22.h),

                            // Container(
                            //   margin: EdgeInsets.symmetric(vertical: 8.h),
                            //   padding: EdgeInsets.all(12.w),
                            //   decoration: BoxDecoration(
                            //     gradient: LinearGradient(
                            //       colors: [softBlueColor, purpleColor],
                            //       begin: Alignment.centerLeft,
                            //       end: Alignment.centerRight,
                            //     ),
                            //     borderRadius: BorderRadius.circular(20.r),
                            //   ),
                            //   child:
                            //   Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       SizedBox(height: 22.h),
                            //       Row(
                            //         children: getIndonesianWeekLabels(getStartOfWeek(DateTime.now()))
                            //             .map((label) => Expanded(
                            //           child: Center(
                            //             child: Text(
                            //               label,
                            //               textAlign: TextAlign.center,
                            //               style:  blackTextStyle.copyWith(
                            //                 fontSize: 12.sp,
                            //                 fontWeight: extraBold,
                            //               ),
                            //             ),
                            //           ),
                            //         ))
                            //             .toList(),
                            //       ),
                            //       const SizedBox(height: 6),
                            //       const Center(
                            //           child: PointBarChart(
                            //         data: [20, -10, 10, -5, 25, 15, 20],
                            //         labels: [
                            //           '20',
                            //           '-10',
                            //           '30',
                            //           '-5',
                            //           '25',
                            //           '15',
                            //           '20'
                            //         ],
                            //       )),
                            //       SizedBox(height: 8.h),
                            //       Column(
                            //         children: List.generate(
                            //           rewardList.take(3).length,
                            //           (index) {
                            //             final reward = rewardList[index];
                            //
                            //             return Container(
                            //               margin: EdgeInsets.only(bottom: 8.h),
                            //               padding: EdgeInsets.all(8.w),
                            //               decoration: BoxDecoration(
                            //                 borderRadius:
                            //                     BorderRadius.circular(12.r),
                            //               ),
                            //               child: Column(
                            //                 children: [
                            //                   Row(
                            //                     crossAxisAlignment:
                            //                         CrossAxisAlignment.start,
                            //                     children: [
                            //                       Text(
                            //                         "${index + 1}.",
                            //                         style:
                            //                             blackTextStyle.copyWith(
                            //                           fontSize: 15.sp,
                            //                           fontWeight: regular,
                            //                         ),
                            //                       ),
                            //                       SizedBox(width: 8.w),
                            //                       Expanded(
                            //                         child: Column(
                            //                           crossAxisAlignment:
                            //                               CrossAxisAlignment
                            //                                   .start,
                            //                           children: [
                            //                             Text(
                            //                               truncateText(
                            //                                   reward['title'] ??
                            //                                       '-',
                            //                                   27),
                            //                               style: blackTextStyle
                            //                                   .copyWith(
                            //                                 fontSize: 15.sp,
                            //                                 fontWeight: regular,
                            //                               ),
                            //                             ),
                            //                             SizedBox(height: 4.h),
                            //                             Text(
                            //                               "Periode: ${reward['periode'] ?? '-'} | Poin: ${reward['point'] ?? '-'}",
                            //                               style: blackTextStyle
                            //                                   .copyWith(
                            //                                 fontSize: 10.sp,
                            //                                 fontWeight: light,
                            //                                 fontStyle: FontStyle
                            //                                     .italic,
                            //                               ),
                            //                             ),
                            //                             SizedBox(height: 4.h),
                            //                           ],
                            //                         ),
                            //                       ),
                            //                       SizedBox(width: 8.w),
                            //                       Row(
                            //                         children: [
                            //                           GestureDetector(
                            //                             onTap: () {
                            //                               Navigator.push(
                            //                                   context,
                            //                                   MaterialPageRoute(
                            //                                       builder: (context) =>
                            //                                       const PointHistoryScreen()));
                            //                             },
                            //                             child: Container(
                            //                               padding:
                            //                                   EdgeInsets.all(
                            //                                       18.w),
                            //                               decoration:
                            //                                   BoxDecoration(
                            //                                 color:
                            //                                 purpleColor,
                            //                               ),
                            //                               child: Icon(
                            //                                 Icons.settings,
                            //                                 size: 18.sp,
                            //                                 color: Colors.white,
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       ),
                            //                     ],
                            //                   ),
                            //                   Container(
                            //                     height: 0.5,
                            //                     width: double.infinity,
                            //                     color: Colors.black,
                            //                   ),
                            //                 ],
                            //               ),
                            //             );
                            //           },
                            //         ),
                            //       ),
                            //       SizedBox(height: 8.h),
                            //       GestureDetector(
                            //         onTap: () {
                            //           Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (context) =>
                            //                   const PointHistoryScreen()));
                            //         },
                            //         child: Center(
                            //           child: Text(
                            //             'Lainnya',
                            //             style: blackTextStyle.copyWith(
                            //               fontSize: 15.sp,
                            //               fontWeight: bold,
                            //               decoration: TextDecoration.underline,
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            SizedBox(height: 22.h),
                            buildFlexibleDataSection<RewardPunishmentBloc,
                                RewardPunishmentState>(
                              title: 'Kondisi Hadiah yang Aktif',
                              status: '',
                              bloc: context.read<RewardPunishmentBloc>(),
                              isLoading: (state) =>
                                  state is ActiveRewardLoading,
                              isSuccess: (state) =>
                                  state is ActiveRewardListLoaded,
                              extractList: (state, status) {
                                return (state as ActiveRewardListLoaded)
                                        .response
                                        .data
                                        .data ??
                                    [];
                              },
                              onTapItem: (context, item) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditRewardScreen(reward: item,)));
                              },
                              onTapMore: (context, status) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RewardDetailScreen(status: 'active',)));
                              },
                            ),
                            SizedBox(height: 22.h),

                            buildFlexibleDataSection<RewardPunishmentBloc,
                                RewardPunishmentState>(
                              title: 'Riwayat Hadiah yang diterima',
                              status: 'history',
                              bloc: context.read<RewardPunishmentBloc>(),
                              isLoading: (state) =>
                                  state is RewardHistoryLoading,
                              isSuccess: (state) =>
                                  state is RewardHistoryListLoaded,
                              extractList: (state, status) {
                                return (state as RewardHistoryListLoaded)
                                        .response
                                        .data
                                        .data ??
                                    [];
                              },
                              onTapItem: (context, item) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            RewardHistoryScreen(reward: item,)));
                              },
                              onTapMore: (context, status) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RewardDetailScreen(status: 'history',)));
                              },
                            ),

                            SizedBox(height: 22.h),

                            buildFlexibleDataSection<RewardPunishmentBloc,
                                RewardPunishmentState>(
                              title: 'Kondisi Hukuman yang Aktif',
                              status: '',
                              bloc: context.read<RewardPunishmentBloc>(),
                              isLoading: (state) =>
                              state is ActivePunishmentLoading,
                              isSuccess: (state) =>
                              state is ActivePunishmentListLoaded,
                              extractList: (state, status) {
                                return (state as ActivePunishmentListLoaded)
                                    .response
                                    .data
                                    .data ??
                                    [];
                              },
                              onTapItem: (context, item) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        EditPunishmentScreen(punishment: item,)));
                              },
                              onTapMore: (context, status) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const PunishmentDetailScreen(status: 'active',)));
                              },
                            ),

                            SizedBox(height: 22.h),

                            buildFlexibleDataSection<RewardPunishmentBloc,
                                RewardPunishmentState>(
                              title: 'Riwayat Hukuman yang diterima',
                              status: 'history',
                              bloc: context.read<RewardPunishmentBloc>(),
                              isLoading: (state) =>
                              state is PunishmentHistoryLoading,
                              isSuccess: (state) =>
                              state is PunishmentHistoryListLoaded,
                              extractList: (state, status) {
                                return (state as PunishmentHistoryListLoaded)
                                    .response
                                    .data
                                    .data ??
                                    [];
                              },
                              onTapItem: (context, item) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const PunishmentHistoryScreen()));
                              },
                              onTapMore: (context, status) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const PunishmentDetailScreen(status: 'history',)));
                              },
                            ),
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

  Widget buildFlexibleDataSection<B extends BlocBase<S>, S>({
    required String title,
    required String status,
    required B bloc,
    required bool Function(S state) isLoading,
    required bool Function(S state) isSuccess,
    required List<dynamic> Function(S state, String status) extractList,
    required void Function(BuildContext context, dynamic item) onTapItem,
    required void Function(BuildContext context, String status) onTapMore,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [softBlueColor, purpleColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: medium,
              ),
            ),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<B, S>(
            bloc: bloc,
            buildWhen: (previous, current) =>
            isLoading(current) || isSuccess(current) || current is RewardPunishmentError,
            builder: (context, state) {
              if (isLoading(state)) {
                return const Center(child: CircularProgressIndicator());
              }
              else if (state is RewardPunishmentError) {
                return Center(
                  child: Text(
                    '${state.message}',
                    style: blackTextStyle.copyWith(fontSize: 16.sp),
                  ),
                );
              } else if (isSuccess(state)) {
                final listData = extractList(state, status);
                final top4Datas = listData.take(4).toList();

                if (listData.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada data',
                      style: blackTextStyle.copyWith(fontSize: 16.sp),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: top4Datas.length,
                      itemBuilder: (context, index) {
                        final item = top4Datas[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
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
                                      item.name ?? 'Judul tidak tersedia',
                                      style: blackTextStyle.copyWith(
                                          fontSize: 15.sp),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      "Periode:  'N/A'}",
                                      style: blackTextStyle.copyWith(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w300,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Container(
                                      height: 0.5,
                                      width: double.infinity,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              GestureDetector(
                                onTap: () => onTapItem(context, item),
                                child: Container(
                                  padding: EdgeInsets.all(13.w),
                                  color: purpleColor,
                                  child: Icon(Icons.settings,
                                      size: 18.sp, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () => onTapMore(context, status),
                      child: Center(
                        child: Text(
                          'Lainnya',
                          style: blackTextStyle.copyWith(
                            fontSize: 15.sp,
                            fontWeight: bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
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
