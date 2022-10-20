import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/constatns/theme.dart';
import 'package:military_mobility_platform_frontend/provider/auth.dart';
import 'package:military_mobility_platform_frontend/provider/drive_info.dart';
import 'package:military_mobility_platform_frontend/provider/driving_history.dart';
import 'package:military_mobility_platform_frontend/provider/reservation_list.dart';
import 'package:military_mobility_platform_frontend/provider/mobility_request.dart';
import 'package:military_mobility_platform_frontend/provider/accident.dart';
import 'package:military_mobility_platform_frontend/provider/operation_info.dart';
import 'package:military_mobility_platform_frontend/service/mobility_assets.dart';
import 'package:provider/provider.dart';
import 'package:military_mobility_platform_frontend/provider/navigation.dart';
import 'package:military_mobility_platform_frontend/widgets/navigated_home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    MobilityAssets.precacheMobilityImages(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: kAppTheme,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NavigationProvider()),
          ChangeNotifierProvider(create: (context) => AuthProvider()),
          ChangeNotifierProvider(
              create: (context) => MobilityRequestProvider()),
          ChangeNotifierProvider(
              create: (context) => ReservationListProvider()),
          ChangeNotifierProvider(create: (context) => DriveInfoProvider()),
          ChangeNotifierProvider(
              create: (context) => MobilityRequestProvider()),
          ChangeNotifierProvider(
              create: (context) => ReservationListProvider()),
          ChangeNotifierProvider(create: (context) => AccidentProvider()),
          ChangeNotifierProvider(create: (context) => OperationInfoProvider()),
          ChangeNotifierProvider(create: (context) => DrivingHistoryProvider()),
        ],
        child: const NavigatedHome(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
