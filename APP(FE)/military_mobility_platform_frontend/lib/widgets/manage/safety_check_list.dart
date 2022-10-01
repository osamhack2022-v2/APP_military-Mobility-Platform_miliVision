import 'package:flutter/material.dart';

class SafetyCheckList extends StatelessWidget {
  const SafetyCheckList({super.key});

  @override
  Widget build(BuildContext context) {
    const subtitle = '안전 점검표';
    return InkWell(
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
                child: Icon(Icons.checklist, size: 60),
              ),
              Text(subtitle, style: TextStyle(fontSize: 16)),
            ]
          )
        ),
        onTap: () {
          
        },
    );
  }
}