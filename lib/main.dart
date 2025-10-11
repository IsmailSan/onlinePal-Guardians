import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_pal_guardians/bloc/avatar_bloc/avatar_bloc.dart';
import 'package:online_pal_guardians/bloc/home_bloc/home_bloc/home_bloc.dart';
import 'package:online_pal_guardians/bloc/home_bloc/logout_bloc/logout_bloc.dart';
import 'package:online_pal_guardians/bloc/login_bloc/login_bloc.dart';
import 'package:online_pal_guardians/bloc/mission_bloc/mission_bloc.dart';
import 'package:online_pal_guardians/bloc/monitoring_bloc/monitoring_bloc.dart';
import 'package:online_pal_guardians/bloc/notification/notification_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/child_profile/child_profile_bloc.dart';
import 'package:online_pal_guardians/bloc/profile_bloc/profile_bloc.dart';
import 'package:online_pal_guardians/bloc/registration_bloc/registration_bloc.dart';
import 'package:online_pal_guardians/bloc/reward_punishment_bloc/reward_punishment_bloc.dart';
import 'package:online_pal_guardians/bloc/schedule_bloc/schedule_bloc.dart';
import 'package:online_pal_guardians/repositories/avatar_repository.dart';
import 'package:online_pal_guardians/repositories/home_repository.dart';
import 'package:online_pal_guardians/repositories/login_repository.dart';
import 'package:online_pal_guardians/repositories/mission_repository.dart';
import 'package:online_pal_guardians/repositories/monitoring_repository.dart';
import 'package:online_pal_guardians/repositories/notification_repository.dart';
import 'package:online_pal_guardians/repositories/profile_repository.dart';
import 'package:online_pal_guardians/repositories/registration_repository.dart';
import 'package:online_pal_guardians/repositories/reward_punishment_repository.dart';
import 'package:online_pal_guardians/repositories/schedule_repository.dart';
import 'package:online_pal_guardians/ui/screens/splash/splash_screen.dart';
import 'package:online_pal_guardians/utils/flavor_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  FlavorConfig(
    flavor: Flavor.DEV,
    values: FlavorValues(baseUrl: "http://onlinepal-web-admin.doterb.com"),
    //http://onlinepal-web-admin.doterb.com"
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider<LoginRepository>(
            create: (context) => LoginRepository(),
          ),
          RepositoryProvider<RegistrationRepository>(
            create: (context) => RegistrationRepository(),
          ),
          RepositoryProvider<HomeRepository>(
            create: (context) => HomeRepository(),
          ),
          RepositoryProvider<ProfileRepository>(
            create: (context) => ProfileRepository(),
          ),
          RepositoryProvider<MissionRepository>(
            create: (context) => MissionRepository(),
          ),
          RepositoryProvider<AvatarRepository>(
            create: (context) => AvatarRepository(),
          ),
          RepositoryProvider<NotificationRepository>(
            create: (context) => NotificationRepository(),
          ),
          RepositoryProvider<ScheduleRepository>(
            create: (context) => ScheduleRepository(),
          ),
          RepositoryProvider<RewardPunishmentRepository>(
            create: (context) => RewardPunishmentRepository(),
          ),
          RepositoryProvider<HomeRepository>(
            create: (context) => HomeRepository(),
          ),
          RepositoryProvider<MonitoringRepository>(
            create: (context) => MonitoringRepository(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(
                loginRepository: context.read<LoginRepository>(),
              ),
            ),
            BlocProvider<RegistrationBloc>(
              create: (context) => RegistrationBloc(
                registrationRepository: context.read<RegistrationRepository>(),
              ),
            ),
            BlocProvider<LogoutBloc>(
              create: (context) => LogoutBloc(
                homeRepository: context.read<HomeRepository>(),
              ),
            ),
            BlocProvider<ProfileBloc>(
              create: (context) => ProfileBloc(
                profileRepository: context.read<ProfileRepository>(),
              ),
            ),
            BlocProvider<ChildProfileBloc>(
              create: (context) => ChildProfileBloc(
                profileRepository: context.read<ProfileRepository>(),
              ),
            ),
            BlocProvider<MissionBloc>(
              create: (context) => MissionBloc(
                missionRepository: context.read<MissionRepository>(),
              ),
            ),
            BlocProvider<AvatarBloc>(
              create: (context) => AvatarBloc(
                avatarRepository: context.read<AvatarRepository>(),
              ),
            ),
            BlocProvider<NotificationBloc>(
              create: (context) => NotificationBloc(
                notificationRepository: context.read<NotificationRepository>(),
              ),
            ),
            BlocProvider<ScheduleBloc>(
              create: (context) => ScheduleBloc(
                scheduleRepository: context.read<ScheduleRepository>(),
              ),
            ),
            BlocProvider<RewardPunishmentBloc>(
              create: (context) => RewardPunishmentBloc(
                rewardPunishmentRepository:
                    context.read<RewardPunishmentRepository>(),
              ),
            ),
            BlocProvider<HomeBloc>(
              create: (context) => HomeBloc(
                homeRepository: context.read<HomeRepository>(),
              ),
            ),
            BlocProvider<MonitoringBloc>(
              create: (context) => MonitoringBloc(
                monitoringRepository: context.read<MonitoringRepository>(),
              ),
            ),
          ],
          child: const MyApp(),
        ),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 900),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.indigo),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
