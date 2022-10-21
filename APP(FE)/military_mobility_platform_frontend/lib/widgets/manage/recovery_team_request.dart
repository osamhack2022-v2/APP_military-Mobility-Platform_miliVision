import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'package:military_mobility_platform_frontend/model/mobility.dart';
import 'package:military_mobility_platform_frontend/provider/auth.dart';
import 'package:military_mobility_platform_frontend/provider/accident.dart';
import 'package:military_mobility_platform_frontend/provider/drive_info.dart';
import 'package:military_mobility_platform_frontend/provider/navigation.dart';
import 'package:military_mobility_platform_frontend/provider/reservation_list.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_pin_picker/map_pin_picker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:military_mobility_platform_frontend/service/toast.dart';
import 'package:military_mobility_platform_frontend/service/snackbar.dart';

class RecoveryTeamRequest extends StatelessWidget {
  const RecoveryTeamRequest({super.key});

  @override
  Widget build(BuildContext context) {
    const subtitle = '구난차량 요청';
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
              child: Icon(Icons.accessibility_outlined, size: 60),
            ),
            Text(subtitle, style: TextStyle(fontSize: 16)),
          ])),
      onTap: () {
        Navigator.push(
            //context, MaterialPageRoute(builder: (childContext) => VehicleLocationCheck(mobility: mobility, context: context))
            context,
            MaterialPageRoute(
                builder: (childContext) => VehicleLocationCheck()));
      },
    ));
  }
}

class VehicleLocationCheck extends StatefulWidget {
  //const VehicleLocationCheck(this.mobility, {super.key, required this.context});

  const VehicleLocationCheck({super.key});
  //final MobilityDTO mobility;

  @override
  State<VehicleLocationCheck> createState() => _VehicleLocationCheckState();
}

class _VehicleLocationCheckState extends State<VehicleLocationCheck> {
  final _controller = Completer<GoogleMapController>();
  MapPickerController mapPickerController = MapPickerController();
  final formatter = NumberFormat('###0.00');
  //현재 위치 가져오는 함수 var gps = await getCurrentLocation(); //gps.latitude gps.longitude

  //첫 화면 시작 위치 설정
  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(36.288496, 127.241703),
    zoom: 14.4746,
  );
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final driveInfoProvider =
        Provider.of<DriveInfoProvider>(context, listen: false);
    if (driveInfoProvider.currentLocation != null) {
      cameraPosition = CameraPosition(
        target: driveInfoProvider.currentLocation!,
        zoom: 14.4746,
      );
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          MapPicker(
            // pass icon widget
            iconWidget: SvgPicture.asset(
              "assets/location_icon.svg",
              height: 60,
            ),
            //add map picker controller
            mapPickerController: mapPickerController,
            child: GoogleMap(
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              // hide location button
              myLocationButtonEnabled: false,
              mapType: MapType.normal,
              // camera position
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onCameraMoveStarted: () {
                // notify map is moving
                mapPickerController.mapMoving!();
                textController.text =
                    "위치 좌표 ${formatter.format(cameraPosition.target.latitude)} ${formatter.format(cameraPosition.target.longitude)}";
              },
              onCameraMove: (cameraPosition) {
                this.cameraPosition = cameraPosition;
              },
              onCameraIdle: () async {
                // notify map stopped moving
                mapPickerController.mapFinishedMoving!();
                //get address name from camera position
                List<Placemark> placemarks = await placemarkFromCoordinates(
                  cameraPosition.target.latitude,
                  cameraPosition.target.longitude,
                );
                // update the ui with the address
                textController.text =
                    '${placemarks.first.name}, ${placemarks.first.administrativeArea}, ${placemarks.first.country}';
              },
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).viewPadding.top + 20,
            width: MediaQuery.of(context).size.width - 50,
            height: 50,
            child: TextFormField(
              maxLines: 3,
              textAlign: TextAlign.center,
              readOnly: true,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero, border: InputBorder.none),
              controller: textController,
            ),
          ),
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: SizedBox(
              height: 50,
              child: TextButton(
                child: const Text(
                  "다음",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontSize: 19,
                    // height: 19/19,
                  ),
                ),
                onPressed: () {
                  final accidentProvider =
                      Provider.of<AccidentProvider>(context, listen: false);
                  accidentProvider.recoveryTeamRequestLocationSet(
                      "lat: ${formatter.format(cameraPosition.target.latitude)} , lon: ${formatter.format(cameraPosition.target.longitude)}");
                  Provider.of<NavigationProvider>(context, listen: false)
                      .animateToTabWithName('recovery request');
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF6200EE)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecoveryTeamRequestContent extends StatefulWidget {
  //const RecoveryTeamRequestContent(this.mobility, {super.key, required this.context, required this.latitude, required this.longitude});
  const RecoveryTeamRequestContent({super.key});

  @override
  State<RecoveryTeamRequestContent> createState() =>
      _RecoveryTeamRequestContentState();
}

class _RecoveryTeamRequestContentState
    extends State<RecoveryTeamRequestContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 10.0)),
            const Padding(
              padding: EdgeInsets.only(left: 10.0, bottom: 20.0),
              child: Text('긴급출동 요청내용을 입력해주세요',
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
            ),
            Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 20.0),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(children: [
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Text('차량번호',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Flexible(
                        child: TextField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        //Mobility.id 넣기
                        hintText: "12하8839",
                        hintStyle: TextStyle(color: Color(0xFFD6D6D6)),
                      ),
                    )),
                  ]),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Text('차량위치',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Flexible(
                        child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "서울특별시 동작구 OOO",
                        hintStyle: TextStyle(color: Color(0xFFD6D6D6)),
                      ),
                    )),
                  ]),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 14.0),
                      child: Text('요청서비스',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Flexible(
                        child: TextField(
                      onChanged: (val) {
                        context
                            .read<AccidentProvider>()
                            .recoveryTeamRequestServiceSet(val);
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "타이어 펑크로 인한 교체",
                        hintStyle: TextStyle(color: Color(0xFFD6D6D6)),
                      ),
                    )),
                  ]),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Text('특이사항',
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold)),
                    ),
                    Flexible(
                        child: TextField(
                      onChanged: (val) {
                        context
                            .read<AccidentProvider>()
                            .recoveryTeamRequestNoteSet(val);
                      },
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "기타 특이사항을 입력해주세요.",
                        hintStyle: TextStyle(color: Color(0xFFD6D6D6)),
                      ),
                    )),
                  ]),
                ])),
            Padding(
              padding: const EdgeInsets.only(top: 17.0),
              child: ElevatedButton(
                onPressed: () {
                  _postRecoveryTeam(context);
                },
                child: const Text('확인', style: TextStyle(fontSize: 18.0)),
              ),
            ),
          ],
        ));
  }

  void _postRecoveryTeam(BuildContext context) {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final accidentProvider =
          Provider.of<AccidentProvider>(context, listen: false);
      final reservationListProvider =
          Provider.of<ReservationListProvider>(context, listen: false);
      accidentProvider
          .postRecoveryTeam(authProvider.authenticatedClient!,
              reservationListProvider.selectedReservation!.mobility)
          .then((_) {
        Snackbar(context).showSuccess('구난 차량 요청이 완료되었습니다.');
        Provider.of<NavigationProvider>(context, listen: false)
            .animateToTabWithName('detailed info');
      });
    } catch (exception) {
      print(exception);
      Toast.showFailToast('구난 차량 요청에 실패했습니다.');
    }
  }
}
