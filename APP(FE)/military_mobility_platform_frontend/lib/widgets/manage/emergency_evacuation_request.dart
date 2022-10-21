import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/provider/navigation.dart';
import 'package:provider/provider.dart';

class EmergencyEvacuationRequest extends StatelessWidget {
  const EmergencyEvacuationRequest({super.key});

  @override
  Widget build(BuildContext context) {
    const subtitle = '응급환자 후송 요청';
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
              child: Icon(Icons.vaccines_outlined, size: 60),
            ),
            Text(subtitle, style: TextStyle(fontSize: 16)),
          ])),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmergencyEvacuationRequestSet()));
      },
    ));
  }
}

class EmergencyEvacuationRequestSet extends StatefulWidget {
  const EmergencyEvacuationRequestSet({super.key});

  @override
  State<EmergencyEvacuationRequestSet> createState() =>
      _EmergencyEvacuationRequestSetState();
}

class _EmergencyEvacuationRequestSetState
    extends State<EmergencyEvacuationRequestSet> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 100.0)),
            Image.asset(
              'assets/images/MEDCOM.jpg',
              width: 100.0,
              height: 120.0,
              fit: BoxFit.cover,
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child:
                    Text('Emergency Center', style: TextStyle(fontSize: 30.0))),
            const Padding(
                padding: EdgeInsets.only(bottom: 30.0),
                child: Text('본 서비스를 이용하기 위해서는 사용자 코드를 입력하셔야 합니다.',
                    style: TextStyle(fontSize: 13.0))),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "사용자 코드 입력",
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30.0),
            ),
            ElevatedButton(
              onPressed: () {
                Provider.of<NavigationProvider>(context, listen: false)
                    .animateToTabWithName('detailed info');
              },
              child: const Text('로그인', style: TextStyle(fontSize: 18.0)),
            ),
          ],
        ));
  }
}
