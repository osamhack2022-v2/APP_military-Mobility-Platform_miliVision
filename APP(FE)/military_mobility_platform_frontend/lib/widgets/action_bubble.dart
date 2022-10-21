import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:military_mobility_platform_frontend/provider/auth.dart';
import 'package:military_mobility_platform_frontend/provider/navigation.dart';
import 'package:military_mobility_platform_frontend/provider/operation_info.dart';
import 'package:military_mobility_platform_frontend/provider/reservation_list.dart';
import 'package:military_mobility_platform_frontend/service/snackbar.dart';
import 'package:military_mobility_platform_frontend/widgets/manage/safety_check_list.dart';
import 'package:provider/provider.dart';

class ActionBubble extends StatefulWidget {
  const ActionBubble({super.key});

  @override
  ActionBubbleState createState() => ActionBubbleState();
}

class ActionBubbleState extends State<ActionBubble>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;
  late NavigationProvider navProvider;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    navProvider = Provider.of<NavigationProvider>(context, listen: false);
    final theme = Theme.of(context);
    final textStyle = GoogleFonts.roboto(
        color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold);
    return FloatingActionBubble(
        items: [
          Bubble(
              icon: Icons.play_arrow,
              iconColor: Colors.white,
              title: '운행시작',
              titleStyle: textStyle,
              bubbleColor: theme.primaryColor,
              onPress: () => _startDrive(context)),
          Bubble(
              icon: Icons.checklist,
              iconColor: Colors.white,
              title: '안전점검표',
              titleStyle: textStyle,
              bubbleColor: theme.primaryColor,
              onPress: () => _safetyChecklist(context)),
          Bubble(
              icon: Icons.menu_book_outlined,
              iconColor: Colors.white,
              title: '운행계획작성',
              titleStyle: textStyle,
              bubbleColor: theme.primaryColor,
              onPress: () => _operationPlan(context)),
          Bubble(
              icon: Icons.car_crash_outlined,
              iconColor: Colors.white,
              title: '사고접수',
              titleStyle: textStyle,
              bubbleColor: theme.primaryColor,
              onPress: () => _accidentReport(context)),
          Bubble(
              icon: Icons.accessibility_outlined,
              iconColor: Colors.white,
              title: '구난차량요청',
              titleStyle: textStyle,
              bubbleColor: theme.primaryColor,
              onPress: () => _recoveryRequest(context)),
          Bubble(
              icon: Icons.vaccines_outlined,
              iconColor: Colors.white,
              title: '응급후송요청',
              titleStyle: textStyle,
              bubbleColor: theme.primaryColor,
              onPress: () => _evacuationRequest(context)),
          Bubble(
              icon: Icons.subdirectory_arrow_left,
              iconColor: Colors.white,
              title: '차량반납',
              titleStyle: textStyle,
              bubbleColor: theme.primaryColor,
              onPress: () => _vehicleReturn(context)),
        ],
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),
        iconColor: Colors.white,
        animatedIconData: AnimatedIcons.menu_close,
        backGroundColor: theme.primaryColor,
        animation: _animation);
  }

  void _startDrive(BuildContext context) async {
    try {
      final navigationProvider =
          Provider.of<NavigationProvider>(context, listen: false);
      navigationProvider.animateToTabWithName('drive');
    } catch (exception) {
      print(exception.toString());
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Snackbar(context).showError('운행탭으로 이동할 수 없습니다.');
      });
    }
    _animationController.reverse();
  }

  void _safetyChecklist(BuildContext context) {
    _animationController.reverse();
    navProvider.animateToTabWithName('checklist');
  }

  void _operationPlan(BuildContext context) {
    _animationController.reverse();
    navProvider.animateToTabWithName('operation plan');
  }

  void _accidentReport(BuildContext context) {
    _animationController.reverse();
    navProvider.animateToTabWithName('accident report');
  }

  void _recoveryRequest(BuildContext context) {
    _animationController.reverse();
    navProvider.animateToTabWithName('check location');
  }

  void _evacuationRequest(BuildContext context) {
    _animationController.reverse();
    navProvider.animateToTabWithName('evacuation request');
  }

  void _vehicleReturn(BuildContext context) async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final operationInfoProvider =
          Provider.of<OperationInfoProvider>(context, listen: false);
      final reservationListProvider =
          Provider.of<ReservationListProvider>(context, listen: false);
      operationInfoProvider.vehicleReturnTrue();
      await operationInfoProvider.returnVehicle(
          authProvider.authenticatedClient!,
          reservationListProvider.selectedReservation!);
      reservationListProvider.deselect();
      await reservationListProvider
          .getReservations(authProvider.authenticatedClient!);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<NavigationProvider>(context, listen: false)
            .animateToTabWithName('list');
        Snackbar(context).showSuccess('차량 반납이 완료되었습니다.');
      });
    } catch (exception) {
      print(exception);
      Snackbar(context).showError('차량 반납에 실패했습니다.');
    } finally {
      _animationController.reverse();
    }
  }
}
