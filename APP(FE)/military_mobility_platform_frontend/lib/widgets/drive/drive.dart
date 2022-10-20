import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:military_mobility_platform_frontend/provider/auth.dart';
import 'package:military_mobility_platform_frontend/provider/drive_info.dart';
import 'package:military_mobility_platform_frontend/provider/navigation.dart';
import 'package:military_mobility_platform_frontend/service/snackbar.dart';
import 'package:military_mobility_platform_frontend/widgets/drive/map.dart';
import 'package:provider/provider.dart';

class DriveTab extends StatelessWidget {
  const DriveTab({super.key});

  @override
  Widget build(BuildContext context) {
    final driveInfoProvider = Provider.of<DriveInfoProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final navigationProvider =
        Provider.of<NavigationProvider>(context, listen: false);
    if (!driveInfoProvider.selectionExists) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Snackbar(context).showError('먼저 운행을 시작할 배차를 선택해주십시오.');
        Provider.of<NavigationProvider>(context, listen: false)
            .animateToTabWithName('list');
      });
      return const Center(child: CircularProgressIndicator());
    }

    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    return Column(children: [
      SizedBox(
        height: height * 0.7,
        child: Stack(alignment: Alignment.center, children: [
          const DriveMap(),
          Positioned(
              bottom: 17.0,
              child: RawMaterialButton(
                onPressed: () async {
                  if (!driveInfoProvider.isDriving) {
                    await driveInfoProvider.startDriveMock();
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Snackbar(context).showInfo('운행을 시작합니다.');
                    });
                  } else {
                    try {
                      final authClient = authProvider.authenticatedClient!;
                      await driveInfoProvider.stopDrive(authClient);
                      navigationProvider.animateToTabWithName('history');
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Snackbar(context).showInfo("운행 기록을 추가했습니다.");
                      });
                    } catch (exception) {
                      Snackbar(context).showError("운행 기록에 실패했습니다.");
                    }
                  }
                },
                elevation: 2.0,
                fillColor: driveInfoProvider.isDriving
                    ? Colors.orange
                    : theme.primaryColor,
                padding: const EdgeInsets.all(17.0),
                shape: const CircleBorder(),
                child: Text(driveInfoProvider.isDriving ? "운행\n정지" : "운행\n시작",
                    style: theme.textTheme.titleLarge),
              ))
        ]),
      ),
      _buildInfoSection(context)
    ]);
  }

  Widget _buildInfoSection(BuildContext context) {
    return Expanded(
        child: Container(
            color: const Color(0xFFDFDFDF),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDrivingTime(context),
                  _buildDrivingDistance(context),
                ])));
  }

  Widget _buildDrivingTime(BuildContext context) {
    final style =
        GoogleFonts.roboto(fontSize: 36.0, fontWeight: FontWeight.bold);
    final time = Provider.of<DriveInfoProvider>(context).drivingTime;
    final hours = time.inHours.toString().padLeft(2, '0');
    final minutes = time.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = time.inSeconds.remainder(60).toString().padLeft(2, '0');
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('운행시간'),
      Text("$hours:$minutes:$seconds", style: style)
    ]);
  }

  Widget _buildDrivingDistance(BuildContext context) {
    final style =
        GoogleFonts.roboto(fontSize: 36.0, fontWeight: FontWeight.bold);
    final distance = Provider.of<DriveInfoProvider>(context).drivingDistance;
    final formatter = NumberFormat('###0.00');
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('운행거리'),
      Text(
        "${formatter.format(distance)} KM",
        style: style,
      )
    ]);
  }
}
