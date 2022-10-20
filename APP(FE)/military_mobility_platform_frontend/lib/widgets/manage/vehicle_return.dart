import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/model/reservation.dart';
import 'package:military_mobility_platform_frontend/provider/auth.dart';
import 'package:military_mobility_platform_frontend/provider/operation_info.dart';
import 'package:provider/provider.dart';
import 'package:military_mobility_platform_frontend/service/toast.dart';
import 'package:military_mobility_platform_frontend/service/snackbar.dart';

class VehicleReturn extends StatelessWidget {
  //const VehicleReturn(this.reservation, {super.key});
  const VehicleReturn({super.key});
  //final ReservationDTO reservation;

  @override
  Widget build(BuildContext context) {
    const subtitle = '차량반납';
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
                child: Icon(Icons.subdirectory_arrow_left, size: 60),
              ),
              Text(subtitle, style: TextStyle(fontSize: 16)),
            ]
          )
        ),
        onTap: () {
          _returnVehicle(context);
        },
      )
    );
  }

  void _returnVehicle(BuildContext context) {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final operationInfoProvider =
          Provider.of<OperationInfoProvider>(context, listen: false);
      operationInfoProvider.vehicleReturnTrue();
      //operationInfoProvider.returnVehicle(authProvider.authenticatedClient!, reservation);
      Snackbar(context).showSuccess('차량 반납이 완료되었습니다.');
    } catch (exception) {
      print(exception);
      Toast.showFailToast('차량 반납에 실패했습니다.');
    }
  }
}