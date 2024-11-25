import 'package:flutter/material.dart';
import 'package:music_player/core/constants/route_constants.dart';
import 'package:music_player/core/enum/route_enum.dart';
import 'package:music_player/core/navigation/app_navigation_manager.dart';
import 'package:music_player/core/navigation/app_navigation_observer.dart';
import 'package:music_player/core/utils/app_initializer.dart';
import 'package:music_player/features/home/home_view_view_model.dart';
import 'package:music_player/features/play_detail/play_detail_view_model.dart';
import 'package:music_player/locator.dart';
import 'package:music_player/utils/app_audio_control_manager.dart';
import 'package:music_player/utils/app_audio_query_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppInitializer.setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeViewViewModel(
            appAudioManager: getIt<AppAudioQueryManager>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => PlayDetailViewModel(
            appAudioControlManager: getIt<AppAudioControlManager>(),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: getIt<AppNavigationManager>().navigatorKey,
        navigatorObservers: [
          AppNavigatiorObserver(),
        ],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case RouteConstants.initialPath:
              return _pageRoute(routeEnum: RouteEnum.initial);
            case RouteConstants.homeViewPath:
              return _pageRoute(routeEnum: RouteEnum.home);
            case RouteConstants.playDetailViewPath:
              return _pageRoute(routeEnum: RouteEnum.playDetail, arg: settings.arguments);
            default:
              return _pageRoute(routeEnum: RouteEnum.home);
          }
        },
        home: const InitialView(),
      ),
    );
  }

  MaterialPageRoute<dynamic> _pageRoute({required RouteEnum routeEnum, Object? arg}) {
    return MaterialPageRoute(
      builder: (context) => routeEnum.toPage(),
      settings: RouteSettings(name: routeEnum.path, arguments: arg),
    );
  }
}

class InitialView extends StatefulWidget {
  const InitialView({super.key});

  @override
  State<InitialView> createState() => _InitialViewState();
}

class _InitialViewState extends State<InitialView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getIt<AppNavigationManager>().navigateTo(RouteEnum.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
