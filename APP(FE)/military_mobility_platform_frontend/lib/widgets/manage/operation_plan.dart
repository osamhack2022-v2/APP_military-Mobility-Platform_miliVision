import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/model/mobility.dart';
import 'package:military_mobility_platform_frontend/model/reservation.dart';
import 'package:military_mobility_platform_frontend/provider/auth.dart';
import 'package:military_mobility_platform_frontend/provider/navigation.dart';
import 'package:military_mobility_platform_frontend/provider/operation_info.dart';
import 'package:military_mobility_platform_frontend/provider/reservation_list.dart';
import 'package:provider/provider.dart';
import 'package:military_mobility_platform_frontend/service/toast.dart';
import 'package:military_mobility_platform_frontend/service/snackbar.dart';

class OperationPlan extends StatelessWidget {
  const OperationPlan({super.key});

  @override
  Widget build(BuildContext context) {
    const subtitle = '운행 계획 작성';

    return Material(
        child: GestureDetector(
      child: Container(
          width: 168,
          height: 149,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(1.0),
                spreadRadius: 0,
                blurRadius: 7,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 25, 0, 20),
              child: Icon(Icons.menu_book_outlined, size: 60),
            ),
            Text(subtitle, style: TextStyle(fontSize: 16)),
          ])),
      onTap: () {
        Navigator.push(
            //context, MaterialPageRoute(builder: (childContext) => OperationPlanSet(reservation: reservation, context: context))
            context,
            MaterialPageRoute(builder: (childContext) => OperationPlanSet()));
      },
    ));
  }
}

class OperationPlanSet extends StatefulWidget {
  //const OperationPlanSet(this.reservation, {super.key, required this.context});
  const OperationPlanSet({super.key});
  //final ReservationDTO reservation;

  @override
  State<OperationPlanSet> createState() => _OperationPlanSetState();
}

class _OperationPlanSetState extends State<OperationPlanSet> {
  @override
  Widget build(BuildContext context) {
    List<bool> _isFilled = [
      false,
      false,
      false,
      false,
    ];

    const inputFieldWidth = 300.0;

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 25.0)),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 12.0),
                child: Text('운전자 정보를 등록해주세요.(*)'),
              ),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                ),
                SizedBox(
                  width: inputFieldWidth,
                  child: TextField(
                    onChanged: (val) {
                      context.read<OperationInfoProvider>().driverInfoSet(val);
                    },
                    decoration: const InputDecoration(
                      hintText: "일병 OOO",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 30.0, top: 5.0),
                child: Text('직접 운전 간부의 경우에는 본인의 성함을 기입해주세요.',
                    style: TextStyle(fontSize: 12.0)),
              ),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 12.0),
                child: Text('선탑자 정보를 등록해주세요.(*)'),
              ),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                ),
                SizedBox(
                  width: inputFieldWidth,
                  child: TextField(
                    onChanged: (val) {
                      context
                          .read<OperationInfoProvider>()
                          .commanderInfoSet(val);
                    },
                    decoration: const InputDecoration(
                      hintText: "중사 OOO",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 30.0, top: 5.0),
                child: Text('직접 운전 간부의 경우에는 본인의 성함을 기입해주세요.',
                    style: TextStyle(fontSize: 12.0)),
              ),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 12.0),
                child: Text('운행 목적을 입력해주세요.(*)'),
              ),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                ),
                SizedBox(
                  width: inputFieldWidth,
                  child: TextField(
                    onChanged: (val) {
                      context
                          .read<OperationInfoProvider>()
                          .operationPurposeSet(val);
                    },
                    decoration: const InputDecoration(
                      hintText: "ex) 환자 후송, 출장, 회의 참석 등",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 30.0, top: 5.0),
                child: Text('운행 목적을 상세하게 입력해주세요.',
                    style: TextStyle(fontSize: 12.0)),
              ),
            ]),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 12.0),
                child: Text('비고기재란.(*)'),
              ),
              Row(children: [
                Padding(
                  padding: EdgeInsets.only(left: 12.0),
                ),
                SizedBox(
                  width: inputFieldWidth,
                  child: TextField(
                    onChanged: (val) {
                      context
                          .read<OperationInfoProvider>()
                          .operationNoteSet(val);
                    },
                    decoration: const InputDecoration(
                      hintText: "ex) 이동 간 동승자 경유지에서 탑승 예정",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(left: 12.0, bottom: 30.0, top: 5.0),
                child: Text('기타 운행계획의 특이사항을 입력해주세요.',
                    style: TextStyle(fontSize: 12.0)),
              ),
            ]),
            Padding(
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  int check = 0;
                  if (context.read<OperationInfoProvider>().driverInfo == "")
                    check++;
                  if (context.read<OperationInfoProvider>().commanderInfo == "")
                    check++;
                  if (context.read<OperationInfoProvider>().operationPurpose ==
                      "") check++;
                  if (context.read<OperationInfoProvider>().operationNote == "")
                    check++;

                  if (check > 0) Toast.showFailToast('모든 항목을 작성해주십이오.');

                  if (check == 0) {
                    _makeOperationPlan(context);
                  }
                },
                child:
                    const Text('운행 계획 작성하기', style: TextStyle(fontSize: 18.0)),
              ),
            ),
          ],
        ));
  }

  void _makeOperationPlan(BuildContext context) {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final operationInfoProvider =
          Provider.of<OperationInfoProvider>(context, listen: false);
      operationInfoProvider.operationPlanSet();
      final reservationListProvider =
          Provider.of<ReservationListProvider>(context, listen: false);
      operationInfoProvider
          .makeOperationPlan(authProvider.authenticatedClient!,
              reservationListProvider.selectedReservation!)
          .then((_) {
        Snackbar(context).showSuccess('운행 계획이 작성되었습니다.');
        Provider.of<NavigationProvider>(context, listen: false)
            .animateToTabWithName('detailed info');
      });
    } catch (exception) {
      print(exception);
      Toast.showFailToast('운행 계획 작성에 실패했습니다.');
    }
  }
}
