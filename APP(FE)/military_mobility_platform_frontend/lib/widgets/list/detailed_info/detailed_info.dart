import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/model/mobility.dart';
import 'package:military_mobility_platform_frontend/provider/drive_info.dart';
import 'package:military_mobility_platform_frontend/provider/reservation_list.dart';
import 'package:military_mobility_platform_frontend/service/mobility_assets.dart';
import 'package:military_mobility_platform_frontend/widgets/list/detailed_info/mobility_manual.dart';
import 'package:provider/provider.dart';

class DetailedInfoTab extends StatelessWidget {
  const DetailedInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    final requestedMobilityListProvider =
        Provider.of<ReservationListProvider>(context);
    final reservation = requestedMobilityListProvider.selectedReservation;
    if (reservation == null) {
      return Container();
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DriveInfoProvider>(context, listen: false)
          .selectReservation(reservation);
    });
    return Column(children: [
      Padding(
          padding: const EdgeInsets.all(36.0),
          child: _buildInfoSection(context, reservation.mobility)),
      Expanded(child: MobilityManual(reservation.mobility)),
    ]);
  }

  Widget _buildInfoSection(BuildContext context, MobilityDTO mobility) {
    final textTheme = Theme.of(context).textTheme;
    return Row(children: [
      Image(
          image: MobilityAssets.getMobilityImage(mobility.type),
          height: 110.0,
          fit: BoxFit.fitHeight),
      const Padding(padding: EdgeInsets.only(left: 24.0)),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(mobility.id.toString()),
        Text(mobility.type, style: textTheme.labelMedium),
        Text("${mobility.fuelType}|${mobility.color}",
            style: textTheme.labelMedium),
        Text("연료: 88%", style: textTheme.labelMedium)
      ])
    ]);
  }
}
