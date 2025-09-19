
import 'package:flutter/material.dart';
import 'package:online_pal_guardians/bloc/notification/notification_bloc.dart';
import 'package:online_pal_guardians/models/notification/notification_list_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/ui/screens/notification/dialog/notification_detail_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/child_profile_selector.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/utils/globals.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  Map<String, List<NotificationItem>>? notifications;
  late ScrollController _scrollController;
  bool _isFetchingMore = false;
  String? _nextCursor;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()..addListener(_onScroll);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    context.read<NotificationBloc>().add(NotificationInitialized());
    context.read<NotificationBloc>().add(GetNotifications(
          search: '',
        ));
  }

  void _onScroll() async {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isFetchingMore &&
        _nextCursor != null) {
      setState(() {
        _isFetchingMore = true;
      });

      context.read<NotificationBloc>().add(GetNotifications(
            search: '',
            cursor: _nextCursor,
            isRefresh: false,
          ));
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
                      "Notifikasi",
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
                SizedBox(height: 60.h),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => {
                        // showDialog(
                        //   context: context,
                        //   builder: (_) => NotificationDetailDialog(
                        //     onGoToMission: () {
                        //       Navigator.of(context).pop();
                        //
                        //         print("Ganti tab ke misi...");
                        //         print("Apakah mainScreenKey currentState null? ${mainScreenKey.currentState == null}");
                        //
                        //         mainScreenKey.currentState?.setState(() {
                        //           print("Sukses set selectedIndex jadi 2");
                        //           mainScreenKey.currentState!.selectedIndex = 2;
                        //         });
                        //
                        //     },
                        //     avatarAsset: '',
                        //     date: '18 Des 2024; 09.15',
                        //     profile: 'Brandon',
                        //     mission:
                        //         'Tidak bermain "Mobile Legends" di hari sekolah.',
                        //     period: 'Setiap hari biasa',
                        //   ),
                        // ),
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
                  child: BlocConsumer<NotificationBloc, NotificationState>(
                    listener: (context, state) {
                      if (state is NotificationError) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => ErrorDialog(message: state.message),
                        );
                      } else if (state is NotificationListSuccess) {
                        _isFetchingMore = false;
                        _nextCursor = state
                            .notificationsListResponse.data?.nextCursor
                            ?.toString();
                      }
                    },
                    builder: (context, state) {
                      if (state is NotificationListSuccess) {
                        notifications =
                            state.notificationsListResponse.data?.data;

                        if (notifications == null || notifications!.isEmpty) {
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
                                  'Notifikasi tidak tersedia',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 16.sp, fontWeight: bold),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView(
                          controller: _scrollController,
                          children: notifications!.entries.map((entry) {
                            final month = entry.key;
                            final notifList = entry.value;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 12.h),
                                  child: Text(
                                    month,
                                    style: blackTextStyle.copyWith(
                                        fontSize: 16.sp, fontWeight: bold),
                                  ),
                                ),
                                ...notifList
                                    .map((notif) =>
                                    _buildNotificationItem(notif))
                                    .toList(),
                              ],
                            );
                          }).toList(),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
          BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              if (state is NotificationLoading) {
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

  Widget _buildNotificationItem(NotificationItem notification) {
    String mission = '-';

    if (notification.data != null &&
        notification.data!.data != null &&
        notification.data!.data!.name != null) {
      mission = notification.data!.data!.name!;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.w),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.notifiedAt ?? "",
                        style: grayTextStyle.copyWith(
                            fontSize: 14.sp, fontWeight: regular),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        notification.title ?? "",
                        style: blackTextStyle.copyWith(
                            fontSize: 14.sp, fontWeight: regular),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        mission,
                        style: grayTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: extraLight,
                            fontStyle: italic),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60.h,
                  child: ElevatedButton(
                    onPressed: () {
                      final detail = notification.data?.data;
                      if (detail != null) {
                        showDialog(
                          context: context,
                          builder: (_) => NotificationDetailDialog(
                            avatarAsset: '',
                            date: notification.notifiedAt ?? "-",
                            profile: detail.children?.childrenProfile?.name ?? "-",
                            mission: detail.name ?? "-",
                            period: detail.periodeTime ?? "-",
                            title: notification.title ?? "-",
                            onGoToMission: () {
                              Navigator.of(context).pop(); // Tutup dialog
                              mainScreenKey.currentState?.setState(() {
                                mainScreenKey.currentState!.selectedIndex = 2;
                              });
                            },
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: purpleColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.w)),
                    ),
                    child: Text(
                      "LIHAT",
                      style: TextStyle(fontSize: 12.sp, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 0.5,
              width: double.infinity,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }

}
