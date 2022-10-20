import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:military_mobility_platform_frontend/provider/drive_info.dart';
import 'package:provider/provider.dart';

class DriveMap extends StatefulWidget {
  const DriveMap({super.key});

  @override
  DriveMapState createState() => DriveMapState();
}

class DriveMapState extends State<DriveMap> {
  static const kZoom = 17.0;
  static const defaultLocation = LatLng(36.288496, 127.241703);
  LatLng? location;

  void loadCurrentLocation(
      DriveInfoProvider provider, GoogleMapController controller) {
    provider.locationStream.listen((currentLocation) {
      location = currentLocation;
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(zoom: kZoom, target: location!),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final driveInfoProvider = Provider.of<DriveInfoProvider>(context);
    return GoogleMap(
      compassEnabled: false,
      mapToolbarEnabled: false,
      rotateGesturesEnabled: false,
      scrollGesturesEnabled: false,
      initialCameraPosition:
          const CameraPosition(target: defaultLocation, zoom: kZoom),
      polylines: {
        Polyline(
          polylineId: const PolylineId("route"),
          points: driveInfoProvider.polyLineCoordinates,
          color: const Color(0xFF7B61FF),
          width: 6,
        ),
      },
      onMapCreated: (controller) =>
          loadCurrentLocation(driveInfoProvider, controller),
    );
  }
}
