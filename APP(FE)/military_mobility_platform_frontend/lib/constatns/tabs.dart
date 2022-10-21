import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/widgets/action_bubble.dart';
import 'package:military_mobility_platform_frontend/widgets/drive/drive.dart';
import 'package:military_mobility_platform_frontend/model/tab.dart';
import 'package:military_mobility_platform_frontend/provider/reservation_list.dart';
import 'package:military_mobility_platform_frontend/provider/navigation.dart';
import 'package:military_mobility_platform_frontend/widgets/history_list/history_list.dart';
import 'package:military_mobility_platform_frontend/widgets/list/detailed_info/detailed_info.dart';
import 'package:military_mobility_platform_frontend/widgets/list/list.dart';
import 'package:military_mobility_platform_frontend/widgets/manage/accident_report.dart';
import 'package:military_mobility_platform_frontend/widgets/manage/emergency_evacuation_request.dart';
import 'package:military_mobility_platform_frontend/widgets/manage/manage.dart';
import 'package:military_mobility_platform_frontend/widgets/manage/operation_plan.dart';
import 'package:military_mobility_platform_frontend/widgets/manage/recovery_team_request.dart';
import 'package:military_mobility_platform_frontend/widgets/manage/safety_check_list.dart';
import 'package:military_mobility_platform_frontend/widgets/request/request.dart';
import 'package:military_mobility_platform_frontend/widgets/request/select_mobility/select_mobility.dart';
import 'package:provider/provider.dart';

const kDefaultAppBarLeading = null;
// IconButton(onPressed: null, icon: Icon(Icons.menu));

const kDefaultAppBarActions = [
  // IconButton(onPressed: null, icon: Icon(Icons.notifications)),
  // IconButton(onPressed: null, icon: Icon(Icons.share)),
  // IconButton(onPressed: null, icon: Icon(Icons.search)),
];

final kTabs = [
  TabVO(
      name: 'request',
      builder: () => const RequestTab(),
      appbar: const AppBarVO(title: '배차신청'),
      navBarItem: const NavBarItemVO(label: '배차신청')),
  TabVO(
    name: 'select mobility',
    appbar: AppBarVO(
        title: '차량선택',
        leading: (context) => IconButton(
            onPressed: () =>
                Provider.of<NavigationProvider>(context, listen: false)
                    .animateToTabWithName('request'),
            icon: const Icon(Icons.arrow_back_ios)),
        actions: (_) => []),
    builder: () => const SelectMobilityTab(),
  ),
  TabVO(
      name: 'list',
      builder: () => const ListTab(),
      appbar: const AppBarVO(title: '배차확인'),
      navBarItem: const NavBarItemVO(label: '배차확인')),
  TabVO(
      name: 'detailed info',
      appbar: AppBarVO(
          title: '상세정보',
          leading: (context) => IconButton(
              onPressed: () {
                Provider.of<ReservationListProvider>(context, listen: false)
                    .deselect();
                Provider.of<NavigationProvider>(context, listen: false)
                    .animateToTabWithName('list');
              },
              icon: const Icon(Icons.arrow_back_ios)),
          actions: (_) => []),
      builder: () => const DetailedInfoTab(),
      floatingButton: (context) {
        final reservationProvider =
            Provider.of<ReservationListProvider>(context);
        if (reservationProvider.selectedReservation == null ||
            !reservationProvider.selectedReservation!.accepted) return null;
        return const ActionBubble();
      }),
  TabVO(
    name: 'checklist',
    builder: () => const SafetyCheckListSet(),
    appbar: AppBarVO(
        title: '안전점검표',
        leading: (context) => IconButton(
            onPressed: () {
              Provider.of<NavigationProvider>(context, listen: false)
                  .animateToTabWithName('detailed info');
            },
            icon: const Icon(Icons.arrow_back_ios))),
  ),
  TabVO(
    name: 'operation plan',
    builder: () => const OperationPlanSet(),
    appbar: AppBarVO(
        title: '운행계획작성',
        leading: (context) => IconButton(
            onPressed: () {
              Provider.of<NavigationProvider>(context, listen: false)
                  .animateToTabWithName('detailed info');
            },
            icon: const Icon(Icons.arrow_back_ios))),
  ),
  TabVO(
    name: 'accident report',
    builder: () => const AccidentReportSet(),
    appbar: AppBarVO(
        title: '사고접수',
        leading: (context) => IconButton(
            onPressed: () {
              Provider.of<NavigationProvider>(context, listen: false)
                  .animateToTabWithName('detailed info');
            },
            icon: const Icon(Icons.arrow_back_ios))),
  ),
  TabVO(
    name: 'set image',
    builder: () => const AccidentReportSetImage(),
    appbar: AppBarVO(
        title: '사고현장사진업로드',
        leading: (context) => IconButton(
            onPressed: () {
              Provider.of<NavigationProvider>(context, listen: false)
                  .animateToTabWithName('detailed info');
            },
            icon: const Icon(Icons.arrow_back_ios))),
  ),
  TabVO(
    name: 'check location',
    builder: () => const VehicleLocationCheck(),
    appbar: AppBarVO(
        title: '차량위치확인',
        leading: (context) => IconButton(
            onPressed: () {
              Provider.of<NavigationProvider>(context, listen: false)
                  .animateToTabWithName('detailed info');
            },
            icon: const Icon(Icons.arrow_back_ios))),
  ),
  TabVO(
    name: 'recovery request',
    builder: () => const RecoveryTeamRequestContent(),
    appbar: AppBarVO(
        title: '구난차량요청',
        leading: (context) => IconButton(
            onPressed: () {
              Provider.of<NavigationProvider>(context, listen: false)
                  .animateToTabWithName('detailed info');
            },
            icon: const Icon(Icons.arrow_back_ios))),
  ),
  TabVO(
    name: 'evacuation request',
    builder: () => const EmergencyEvacuationRequestSet(),
    appbar: AppBarVO(
        title: '응급환자 후송요청',
        leading: (context) => IconButton(
            onPressed: () {
              Provider.of<NavigationProvider>(context, listen: false)
                  .animateToTabWithName('detailed info');
            },
            icon: const Icon(Icons.arrow_back_ios))),
  ),
  TabVO(
      name: 'history',
      builder: () => const HistoryListTab(),
      appbar: const AppBarVO(title: '운행이력'),
      navBarItem: const NavBarItemVO(label: '운행이력')),
  TabVO(
      name: 'drive',
      builder: () => const DriveTab(),
      appbar: const AppBarVO(title: '운행시작')),
];
