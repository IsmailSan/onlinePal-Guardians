import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_pal_guardians/bloc/home_bloc/home_bloc/home_bloc.dart';
import 'package:online_pal_guardians/models/home/home_response.dart';
import 'package:online_pal_guardians/shared/theme.dart';
import 'package:online_pal_guardians/ui/screens/mission/child_mission_screen.dart';
import 'package:online_pal_guardians/ui/screens/monitoring/usage_monitoring_screen.dart';
import 'package:online_pal_guardians/ui/screens/rewardandpunishment/reward_punishment_screen.dart';
import 'package:online_pal_guardians/ui/screens/schedule/child_schedule_screen.dart';
import 'package:online_pal_guardians/ui/widgets/error_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/loading_dialog.dart';
import 'package:online_pal_guardians/ui/widgets/menu_item.dart';
import 'package:online_pal_guardians/ui/widgets/more_options_dropdown.dart';
import 'package:online_pal_guardians/ui/widgets/slider_child_item.dart';
import 'package:online_pal_guardians/models/profile/child_profile/get_children_profile_response.dart';
import 'package:online_pal_guardians/utils/text_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        Widget page;
        if (settings.name == '/childMission') {
          page = const ChildMissionScreen();
        } else if (settings.name == '/usageMonitoring') {
          page = const UsageMonitoringScreen();
        } else if (settings.name == '/childSchedule') {
          page = const ChildScheduleScreen();
        } else if (settings.name == '/rewardPunishment') {
          page = const RewardPunishmentScreen();
        } else {
          page = const ChildMissionScreen();
        }
        return MaterialPageRoute(builder: (context) => page);
      },
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  final PageController _controller = PageController(initialPage: 0);
  int _currentPage = 0;
  ChildProfile? selectedProfile;
  bool isProfileInitialized = false;
  bool hasInitializedProfile = false;
  List<SliderChildItem> sliderItems = [];

  void _nextPage() {
    if (_currentPage < sliderItems.length - 1) {
      _controller.animateToPage(
        _currentPage + 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (_currentPage > 0) {
      _controller.animateToPage(
        _currentPage - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void updateSliderItemsFromHomeResponse(List<HomeData> dataList) {
    setState(() {
      sliderItems = dataList.map((data) {
        return SliderChildItem(
            points: data.child?.points?.point ?? 0,
            name: data.child?.childrenProfile?.name ?? '-',
            hpTime: "",
            tabletTime: "",
            lastHp: "",
            lastTablet: "",
            parentAvatarUrl: data.profile?.imageUrl ?? '',
            childAvatarUrl: '',
            favoritePhysicalActivities:
                data.child?.childrenProfile?.favoritePhysicalActivities ?? [],
          hobbies: data.child?.childrenProfile?.hobbies ?? [],
        );

      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        context.read<HomeBloc>().add(HomeEventInitialized());
        context.read<HomeBloc>().add(GetHome());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _navigatorKey.currentState?.canPop() ?? false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && _navigatorKey.currentState!.canPop()) {
          _navigatorKey.currentState!.pop();
        }
        if (result != null) {
          //
        }
      },
      child: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/childMission':
              return MaterialPageRoute(
                builder: (_) => const ChildMissionScreen(),
                settings: const RouteSettings(name: '/childMission'),
              );
            case '/usageMonitoring':
              return MaterialPageRoute(
                builder: (_) => const UsageMonitoringScreen(),
                settings: const RouteSettings(name: '/usageMonitoring'),
              );
            case '/childSchedule':
              return MaterialPageRoute(
                builder: (_) => const ChildScheduleScreen(),
                settings: const RouteSettings(name: '/childSchedule'),
              );
            case '/rewardPunishment':
              return MaterialPageRoute(
                builder: (_) => const RewardPunishmentScreen(),
                settings: const RouteSettings(name: '/rewardPunishment'),
              );
            default:
              return MaterialPageRoute(
                builder: (_) => _buildHome(),
                settings: const RouteSettings(name: '/'),
              );
          }
        },
      ),
    );
  }

  Widget _buildHome() {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: const Alignment(0, 2.2),
              child: Image.asset(
                'assets/home_wave_bg.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child:
                BlocConsumer<HomeBloc, HomeState>(listener: (context, state) {
              if (state is HomeError) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) => ErrorDialog(message: state.message),
                );
              } else if (state is GetHomeSuccess) {

                updateSliderItemsFromHomeResponse(state.response.data ?? []);
              }
            }, builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 100.h),
                        // Expanded(
                        //   child: Container(
                        //     height: 40.h,
                        //     padding: EdgeInsets.symmetric(horizontal: 12.w),
                        //     decoration: BoxDecoration(
                        //       color: lightBlueColor,
                        //       borderRadius: BorderRadius.circular(20.w),
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
                        SizedBox(width: 20.w),
                        // ChildProfileSelector(),
                        SizedBox(width: 14.w),
                        MoreOptionsDropdown(),
                      ],
                    ),
                  ),
                  Center(
                    child: Text(
                      "Selamat datang kembali, Ayah!",
                      style: blackTextStyle.copyWith(
                          fontSize: 16.sp, fontWeight: semiBold),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: _currentPage > 0 ? _prevPage : null,
                        child: const Icon(Icons.arrow_left,
                            size: 40, color: Colors.blue),
                      ),
                      Expanded(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: 200.h,
                          ),
                          child: PageView.builder(
                            controller: _controller,
                            itemCount: sliderItems.isNotEmpty ? sliderItems.length : 1,
                            onPageChanged: (index) {
                              setState(() {
                                _currentPage = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              if (sliderItems.isEmpty) {
                                return SizedBox(
                                  height: double.infinity,
                                  child: Center(
                                    child: SliderChildItem(
                                      points: 0,
                                      name: 'Tidak ada data anak',
                                      hpTime: '-',
                                      tabletTime: '-',
                                      lastHp: '-',
                                      lastTablet: '-',
                                      parentAvatarUrl: '',
                                      childAvatarUrl: '',
                                      favoritePhysicalActivities: [],
                                      hobbies: [],
                                    ),
                                  ),
                                );
                              }

                              return SizedBox(
                                height: double.infinity,
                                child: Center(child: sliderItems[index]),
                              );
                            },
                          ),

                        ),
                      ),
                      GestureDetector(
                        onTap: _currentPage < sliderItems.length - 1
                            ? _nextPage
                            : null,
                        child: const Icon(Icons.arrow_right,
                            size: 40, color: Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MenuItem(
                          assetPath: 'assets/mission_menu.png',
                          width: 60.w,
                          height: 75.h,
                          onTap: () {
                            _navigatorKey.currentState!
                                .pushNamed('/childMission');
                          },
                        ),
                        MenuItem(
                          assetPath: 'assets/monitoring_menu.png',
                          width: 60.w,
                          onTap: () {
                            _navigatorKey.currentState!
                                .pushNamed('/usageMonitoring');
                          },
                        ),
                        MenuItem(
                          width: 60.w,
                          assetPath: 'assets/schedule_menu.png',
                          onTap: () {
                            _navigatorKey.currentState!
                                .pushNamed('/childSchedule');
                          },
                        ),
                        // MenuItem(
                        //   width: 60.w,
                        //   assetPath: 'assets/target_menu.png',
                        //   onTap: () => print('Target Penggunaan diklik'),
                        // ),
                        MenuItem(
                          width: 60.w,
                          assetPath: 'assets/reward_punishment_menu.png',
                          onTap: () {
                            _navigatorKey.currentState!
                                .pushNamed('/rewardPunishment');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                          ),
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.w),
                                margin: EdgeInsets.only(top: 20.h),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.w),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Misi Hari Ini",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: semiBold),
                                    ),
                                    SizedBox(height: 20.h),
                                    if (state is GetHomeSuccess && (state.response.data.isNotEmpty ?? false))
                                      ...state.response.data.map((homeData) {
                                        final missions = homeData.missionsToday;
                                        final childName = homeData.child?.childrenProfile?.name ?? '-';

                                        if (missions == null || missions.isEmpty) {
                                          return Column(
                                            children: [
                                              Text(
                                                'Tidak ada misi untuk $childName',
                                                style: blackTextStyle.copyWith(fontSize: 14.sp),
                                              ),
                                              SizedBox(height: 10.h),
                                            ],
                                          );
                                        }

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Misi untuk $childName:',
                                              style: blackTextStyle.copyWith(
                                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 10.h),
                                            ...List.generate(missions.length, (index) {
                                              final mission = missions[index];
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Text(
                                                  "${index + 1}. ${mission.name ?? '-'}",
                                                  style: blackTextStyle.copyWith(fontSize: 14.sp),
                                                ),
                                              );
                                            }),
                                            SizedBox(height: 20.h),
                                          ],
                                        );
                                      }).toList()
                                    else
                                      Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              'assets/no_data.png',
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              'Misi tidak tersedia',
                                              style:
                                              blackTextStyle.copyWith(fontSize: 16.sp, fontWeight: bold),
                                            ),
                                          ],
                                        ),
                                      ),

                                  ],
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Container(
                                padding: EdgeInsets.all(10.w),
                                margin: EdgeInsets.only(bottom: 80.h),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.w),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Jadwal Hari Ini",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: semiBold),
                                    ),
                                    SizedBox(height: 20.h),
                                    if (state is GetHomeSuccess && (state.response.data.isNotEmpty ?? false))
                                      ...state.response.data.map((homeData) {
                                        final schedules = homeData.schedulesToday;
                                        final childName = homeData.child?.childrenProfile?.name ?? '-';

                                        if (schedules == null || schedules.isEmpty) {
                                          return Column(
                                            children: [
                                              Text(
                                                'Tidak ada jadwal untuk $childName',
                                                style: blackTextStyle.copyWith(fontSize: 14.sp),
                                              ),
                                              SizedBox(height: 10.h),
                                            ],
                                          );
                                        }

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Jadwal untuk $childName:',
                                              style: blackTextStyle.copyWith(
                                                  fontSize: 16.sp, fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(height: 10.h),
                                            ...List.generate(schedules.length, (index) {
                                              final schedule = schedules[index];
                                              final timeRange =
                                                  "${formatScheduleTime(schedule.timeStart)} - ${formatScheduleTime(schedule.timeEnd)}";
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 8.0),
                                                child: Text(
                                                  "$timeRange ${schedule.customName ?? '-'}",
                                                  style: blackTextStyle.copyWith(fontSize: 14.sp),
                                                ),
                                              );
                                            }),
                                            SizedBox(height: 20.h),
                                          ],
                                        );
                                      }).toList()
                                    else
                                      Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              'assets/no_data.png',
                                              width: 70,
                                              height: 70,
                                              fit: BoxFit.contain,
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              'Misi tidak tersedia',
                                              style:
                                              blackTextStyle.copyWith(fontSize: 16.sp, fontWeight: bold),
                                            ),
                                          ],
                                        ),
                                      ),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              );
            }),
          ),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
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
