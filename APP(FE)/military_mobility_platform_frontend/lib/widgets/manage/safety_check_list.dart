import 'dart:io';
import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/model/mobility.dart';
import 'package:military_mobility_platform_frontend/model/reservation.dart';
import 'package:military_mobility_platform_frontend/provider/auth.dart';
import 'package:military_mobility_platform_frontend/provider/navigation.dart';
import 'package:military_mobility_platform_frontend/provider/operation_info.dart';
import 'package:military_mobility_platform_frontend/provider/reservation_list.dart';
import 'package:provider/provider.dart';
import 'package:military_mobility_platform_frontend/widgets/manage/manage.dart';
import 'package:military_mobility_platform_frontend/service/toast.dart';
import 'package:military_mobility_platform_frontend/service/snackbar.dart';

class SafetyCheckList extends StatelessWidget {
  const SafetyCheckList({super.key});

  @override
  Widget build(BuildContext context) {
    const subtitle = '안전 점검표';
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
              child: Icon(Icons.checklist, size: 60),
            ),
            Text(subtitle, style: TextStyle(fontSize: 16)),
          ])),
      onTap: () {
        Navigator.push(
            //context, MaterialPageRoute(builder: (childContext) => SafetyCheckListSet(reservation: reservation, context: context))
            context,
            MaterialPageRoute(builder: (childContext) => SafetyCheckListSet()));
      },
    ));
  }
}

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    super.key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label, style: TextStyle(fontSize: 14.0))),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
              activeColor: Color(0xFF6200EE),
            ),
          ],
        ),
      ),
    );
  }
}

class SafetyCheckListSet extends StatefulWidget {
  //const SafetyCheckListSet(this.reservation, {super.key, required this.context});

  const SafetyCheckListSet({super.key});
  //final ReservationDTO reservation;

  @override
  State<SafetyCheckListSet> createState() => _SafetyCheckListSetState();
}

class _SafetyCheckListSetState extends State<SafetyCheckListSet> {
  List<bool> _isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabeledCheckbox(
              label: '어느 한쪽 타이어의 공기압력이 현저히 줄어들지 않았는가?',
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              value: _isSelected[0],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[0] = newValue;
                });
              },
            ),
            LabeledCheckbox(
              label: '타이어가 지면에 닿는 트레드 부분이 과마모되지 않았는가?',
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              value: _isSelected[1],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[1] = newValue;
                });
              },
            ),
            LabeledCheckbox(
              label: '각 타이어 측면이 갈라지거나 찢기지 않았는가?',
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              value: _isSelected[2],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[2] = newValue;
                });
              },
            ),
            LabeledCheckbox(
              label: '클러치나 브레이크 페달의 유격 및 브레이크 액의 수준은 양호한가?',
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              value: _isSelected[3],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[3] = newValue;
                });
              },
            ),
            LabeledCheckbox(
              label: '각종오일(엔진오일, 파워핸들 오일, 자동변속기 오일 등)의 양은 적정한가?',
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              value: _isSelected[4],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[4] = newValue;
                });
              },
            ),
            LabeledCheckbox(
              label: '각종 안전장구류(삼각대, 스노우체인 등)은 보유하고 있는가?',
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              value: _isSelected[5],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[5] = newValue;
                });
              },
            ),
            LabeledCheckbox(
              label: '장시간 운행 시 적정한 휴식을 취하며 적당한 스트레칭을 하는가?',
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              value: _isSelected[6],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[6] = newValue;
                });
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  int check = 0;
                  for (int i = 0; i < _isSelected.length; i++) {
                    if (_isSelected[i] == false) {
                      Snackbar(context).showError('모든 항목을 체크해주십이오.');
                      check++;
                      break;
                    }
                  }
                  if (check == 0) {
                    _confirmSafetyCheck(context);
                  }
                },
                child:
                    const Text('안전 점검표 제출하기', style: TextStyle(fontSize: 18.0)),
              ),
            ),
          ],
        ));
  }

  void _confirmSafetyCheck(BuildContext context) {
    try {
      final authProvider =
          Provider.of<AuthProvider>(this.context, listen: false);
      final operationInfoProvider =
          Provider.of<OperationInfoProvider>(context, listen: false);
      final reservationListProvider =
          Provider.of<ReservationListProvider>(context, listen: false);
      final navigationProvider =
          Provider.of<NavigationProvider>(context, listen: false);
      operationInfoProvider.safetyCheckTrue();
      operationInfoProvider
          .confirmSafetyCheck(authProvider.authenticatedClient!,
              reservationListProvider.selectedReservation!)
          .then((_) {
        Snackbar(context).showSuccess('안전 점검표가 제출되었습니다.');
        navigationProvider.animateToTabWithName('detailed info');
      });
    } catch (exception) {
      print(exception);
      Toast.showFailToast('안전 점검표 제출에 실패했습니다.');
    }
  }
}
