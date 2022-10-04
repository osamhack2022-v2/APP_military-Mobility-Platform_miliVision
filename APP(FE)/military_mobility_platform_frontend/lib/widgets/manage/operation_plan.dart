import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/provider/operation_info.dart';

class OperationPlan extends StatelessWidget {
  const OperationPlan({super.key});

  @override
  Widget build(BuildContext context) {
    const subtitle = '운행 계획 작성';
    final operationInfoProvider = Provider.of<OperationInfoProvider>(context);
    final driverInfo = operationInfoProvider.driverInfo;
    final commanderInfo = operationInfoProvider.commanderInfo;
    final operationPurpose = operationInfoProvider.operationPurpose;
    final operationNote = operationInfoProvider.operationNote;

    return Material( child:
    GestureDetector(
      child: 
        Container(
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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0,25,0,20),
                child: Icon(Icons.menu_book_outlined, size: 60),
              ),
              Text(subtitle, style: TextStyle(fontSize: 16)),
            ]
          )
        ),
        onTap: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => OperationPlanSet())
          );
        },
    )
    );
  }
}

class OperationPlanSet extends StatefulWidget {
  const OperationPlanSet({super.key});

  @override
  State<OperationPlanSet> createState() => _OperationPlanSetState();
}

class _OperationPlanSetState extends State<OperationPlanSet> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            iconSize: 15.0,
            onPressed: () {Navigator.of(context).pop();},
          ),
          const Padding(
              padding: EdgeInsets.only(bottom: 10.0)
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('운행 계획 작성', style: TextStyle(fontSize: 22.5, fontWeight: FontWeight.bold)),
          ),
          const Padding(
              padding: EdgeInsets.only(bottom: 10.0)
          ),
          Column( children: [
            Text('운전자 정보를 등록해주세요.(*)'),
            TextField(
              decoration: const InputDecoration(hintText: "일병 OOO"),

            ),
            Text('직접 운전 간부의 경우에는 본인의 성함을 기입해주세요.'),
          ]),
          Column( children: [
            Text('선탑자 정보를 등록해주세요.(*)'),
            Text('일병 ㅇㅇㅇ'),
            Text('직접 운전 간부의 경우에는 본인의 성함을 기입해주세요.'),
          ]),
          Column( children: [
            Text('운행 목적을 입력해주세요.(*)'),
            Text('일병 ㅇㅇㅇ'),
            Text('직접 운전 간부의 경우에는 본인의 성함을 기입해주세요.'),
          ]),
          Column( children: [
            Text('비고기재란.(*)'),
            Text('일병 ㅇㅇㅇ'),
            Text('직접 운전 간부의 경우에는 본인의 성함을 기입해주세요.'),
          ]),
          Padding(
            padding: const EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () => print('clicked'), 
              child: const Text('운행 계획 작성하기', style: TextStyle(fontSize: 18.0)),
            ),
          ),
        ],
      )
    );
  }
}