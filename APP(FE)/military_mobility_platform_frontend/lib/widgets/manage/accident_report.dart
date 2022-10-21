import 'package:flutter/material.dart';
import 'dart:io' as io;
import 'package:military_mobility_platform_frontend/model/mobility.dart';
import 'package:military_mobility_platform_frontend/provider/auth.dart';
import 'package:military_mobility_platform_frontend/provider/accident.dart';
import 'package:military_mobility_platform_frontend/provider/navigation.dart';
import 'package:military_mobility_platform_frontend/provider/reservation_list.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:military_mobility_platform_frontend/service/toast.dart';
import 'package:military_mobility_platform_frontend/service/snackbar.dart';

class AccidentReport extends StatelessWidget {
  const AccidentReport({super.key});

  @override
  Widget build(BuildContext context) {
    const subtitle = '사고접수';
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
              child: Icon(Icons.car_crash_outlined, size: 60),
            ),
            Text(subtitle, style: TextStyle(fontSize: 16)),
          ])),
      onTap: () {
        Navigator.push(
            //context, MaterialPageRoute(builder: (childContext) => AccidentReportSet(mobility: mobility, context: context))
            context,
            MaterialPageRoute(builder: (childContext) => AccidentReportSet()));
      },
    ));
  }
}

class AccidentReportSet extends StatefulWidget {
  //const AccidentReportSet(this.mobility, {super.key, required this.context});

  const AccidentReportSet({super.key});
  //final MobilityDTO mobility;

  @override
  State<AccidentReportSet> createState() => _AccidentReportSetState();
}

class _AccidentReportSetState extends State<AccidentReportSet> {
  String dropdownvalue = '차 대 사람';
  var items = [
    '차 대 사람',
    '차 대 차',
    '차 대 이륜차',
    '차 대 자전거',
    '고속도로',
  ];
  String accidentLocationState = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '사고 유형을 선택해주세요.',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            DropdownButton(
              isExpanded: true,
              value: dropdownvalue,
              icon: const Icon(Icons.keyboard_arrow_down),
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
                context.read<AccidentProvider>().accidentTypeSet(dropdownvalue);
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 200.0, bottom: 12.0),
              child: Text('사고 위치를 입력해주세요.',
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
            ),
            TextField(
                decoration: const InputDecoration(
                  hintText: "서울특별시 동작구 OOO번길 OO",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                onChanged: (val) {
                  context.read<AccidentProvider>().accidentLocationSet(val);
                  setState(() {
                    accidentLocationState = val;
                  });
                }),
            /*
              Padding(
                    padding: EdgeInsets.only(left: 12.0, bottom: 50.0, top: 5.0),
                    child: Text('오른쪽 아이콘을 클릭해서 현재 위치를 조회해주세요.', style: TextStyle(fontSize: 12.0)),
              ),
              */
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: ElevatedButton(
                onPressed: () {
                  final accidentProvider =
                      Provider.of<AccidentProvider>(context, listen: false);
                  accidentProvider.accidentTypeSet(dropdownvalue);
                  accidentProvider.accidentLocationSet(accidentLocationState);
                  Provider.of<NavigationProvider>(context, listen: false)
                      .animateToTabWithName('set image');
                },
                child: const Text('다음', style: TextStyle(fontSize: 18.0)),
              ),
            )
          ],
        ));
  }
}

class AccidentReportSetImage extends StatefulWidget {
  //const AccidentReportSetImage(this.mobility, {super.key, required this.context, required this.accidentTypeState, required this.accidentLocationState, });
  const AccidentReportSetImage({
    super.key,
  });

  @override
  State<AccidentReportSetImage> createState() => _AccidentReportSetImageState();
}

class _AccidentReportSetImageState extends State<AccidentReportSetImage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AccidentProvider>(
        create: (_) => AccidentProvider(),
        builder: (context, child) {
          return Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //웹에서 작동 시 주석처리하는 이미지 불러오는 부분
                  /* 
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Container( 
                  height: 400,
                  width: 380,
                  decoration: BoxDecoration(border: Border.all(),), 
                  child: Image.file(context.read<AccidentProvider>().accidentImage) == null
                        ?Text('')
                        :Image.file(context.read<AccidentProvider>().accidentImage),
                ),
              ),
              */
                  Padding(
                    padding: const EdgeInsets.only(bottom: 27.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext cntx) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.camera),
                                    title: Text("카메라에서 사진 업로드하기"),
                                    onTap: () async {
                                      var picker = ImagePicker();
                                      var image = await picker.pickImage(
                                          source: ImageSource.camera);
                                      if (image != null) {
                                        context
                                            .read<AccidentProvider>()
                                            .accidentImageSet(
                                                io.File(image.path));
                                      }
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.image),
                                    title: Text("갤러리에서 사진 업로드하기"),
                                    onTap: () async {
                                      var picker = ImagePicker();
                                      var image = await picker.pickImage(
                                          source: ImageSource.gallery);
                                      if (image != null) {
                                        context
                                            .read<AccidentProvider>()
                                            .accidentImageSet(
                                                io.File(image.path));
                                      }
                                    },
                                  ),
                                  Container(
                                    height: 50,
                                    color: Colors.white,
                                    child: ListTile(
                                      title: Center(
                                        child: Text(
                                          "Cancel",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                      child: const Text('사진 업로드하기',
                          style: TextStyle(fontSize: 18.0)),
                    ),
                  ),
                  /* 수정 전 ui
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    var picker = ImagePicker();
                    var image = await picker.pickImage(source: ImageSource.camera);
                    if (image != null) {
                      context.read<AccidentProvider>().accidentImageSet(io.File(image.path));
                    }
                  },
                  child: const Text('카메라에서 사진 업로드하기', style: TextStyle(fontSize: 18.0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    var picker = ImagePicker();
                    var image = await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      context.read<AccidentProvider>().accidentImageSet(io.File(image.path));
                    }
                  }, 
                  child: const Text('갤러리에서 사진 업로드하기', style: TextStyle(fontSize: 18.0)),
                ),
              ),*/
                  ElevatedButton(
                    onPressed: () {
                      _postAccidentReport(context);
                    },
                    child: const Text('접수하기', style: TextStyle(fontSize: 18.0)),
                  ),
                ],
              ));
        });
  }

  void _postAccidentReport(BuildContext context) {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final accidentProvider =
          Provider.of<AccidentProvider>(context, listen: false);
      final reservationListProvider =
          Provider.of<ReservationListProvider>(context, listen: false);
      accidentProvider
          .postAccidentReport(authProvider.authenticatedClient!,
              reservationListProvider.selectedReservation!.mobility)
          .then((_) {
        Snackbar(context).showSuccess('사고 접수가 완료되었습니다.');
        Provider.of<NavigationProvider>(context, listen: false)
            .animateToTabWithName('detailed info');
      });
    } catch (exception) {
      print(exception);
      Toast.showFailToast('사고 접수에 실패했습니다.');
    }
  }
}
