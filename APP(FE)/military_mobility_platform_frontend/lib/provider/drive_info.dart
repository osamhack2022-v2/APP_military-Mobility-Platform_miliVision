import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:military_mobility_platform_frontend/model/mileage.dart';
import 'package:military_mobility_platform_frontend/model/reservation.dart';
import 'package:military_mobility_platform_frontend/service/api.dart';
import 'package:military_mobility_platform_frontend/service/distance.dart';

class DriveInfoProvider extends ChangeNotifier {
  ReservationDTO? _reservation;
  Location? _location;
  final StreamController<LatLng> _locationStreamController =
      StreamController<LatLng>();
  List<LatLng> _polyLineCoordinates = [];
  LatLng? _currentLocation;
  DateTime? _startTime;
  double _totalDistance = 0.0;
  Timer? _mockTimer;
  Timer? _timeTimer;

  ReservationDTO? get reservation => _reservation;
  bool get selectionExists => _reservation != null;
  bool get isDriving => _location != null;
  Stream<LatLng> get locationStream => _locationStreamController.stream;
  Duration get drivingTime => _startTime != null
      ? DateTime.now().difference(_startTime!)
      : const Duration(seconds: 0);
  double get drivingDistance => _totalDistance;
  List<LatLng> get polyLineCoordinates => _polyLineCoordinates;
  LatLng? get currentLocation => _currentLocation;

  void selectReservation(ReservationDTO reservation) {
    _reservation = reservation;
    notifyListeners();
  }

  void deselectReservation() {
    _reservation = null;
    notifyListeners();
  }

  Future<void> startDrive() async {
    _initDataToStartDrive();

    final currentLocation = await _location!.getLocation();
    _updateLocation(
        LatLng(currentLocation.latitude!, currentLocation.longitude!));
    _location!.onLocationChanged.listen((newLocation) {
      _updateLocation(LatLng(newLocation.latitude!, newLocation.longitude!));
    });
  }

  Future<void> stopDrive(Dio authClient) async {
    if (_mockTimer != null) {
      _mockTimer!.cancel();
    }
    if (_timeTimer != null) {
      _timeTimer!.cancel();
    }
    _location = null;
    notifyListeners();

    try {
      final reservation = _reservation!;
      await APIService(authClient).makeHistory(MakeHistoryReqDTO(
          carID: reservation.mobility.id,
          departure: reservation.departure,
          destination: reservation.destination,
          datetime: DateTime.now(),
          totalTime: drivingTime.inSeconds,
          totalRange: (drivingDistance * 1000.0).round()));
    } catch (exception) {
      return Future.error(exception);
    }
  }

  Future<void> startDriveMock() async {
    const mockLocs = <LatLng>[
      LatLng(36.288496, 127.241703),
      LatLng(36.288824, 127.240409),
      LatLng(36.288902, 127.240017),
      LatLng(36.288941, 127.239668),
      LatLng(36.288924, 127.239260),
      LatLng(36.288807, 127.238772),
      LatLng(36.288587, 127.238270),
      LatLng(36.286918, 127.234991),
      LatLng(36.286723, 127.234632),
      LatLng(36.286576, 127.234186),
      LatLng(36.286489, 127.233581),
      LatLng(36.286489, 127.233581),
      LatLng(36.283242, 127.232852),
      LatLng(36.283138, 127.234151),
      LatLng(36.282971, 127.235548),
      LatLng(36.282074, 127.239128),
      LatLng(36.282074, 127.239128),
      LatLng(36.288496, 127.241703),
      LatLng(36.288496, 127.241703),
    ];
    final mockTimes = <double>[
      0,
      6,
      10,
      12,
      14,
      16,
      18,
      34,
      36,
      38,
      41,
      55,
      75,
      79,
      84,
      96,
      120,
      150,
      1000,
    ].map((e) => e * 1.0).toList();
    _initDataToStartDrive();

    const interval = 0.5;
    var baseTime = 0;
    var idx = 0;
    _mockTimer = Timer.periodic(
        Duration(milliseconds: (1000.0 * interval).round()), (timer) {
      final elapsedTime = (drivingTime.inMilliseconds - baseTime) / 1000.0;
      var nextIdx = (idx + 1) % mockTimes.length;
      if (elapsedTime >= mockTimes[nextIdx]) {
        idx = nextIdx;
        nextIdx = (idx + 1) % mockTimes.length;
        if (nextIdx == 0) {
          idx = 0;
          nextIdx = (idx + 1) % mockTimes.length;
          baseTime = drivingTime.inMilliseconds;
        }
      }

      final t = (elapsedTime - mockTimes[idx]) /
          (mockTimes[nextIdx] - mockTimes[idx]);
      final a = mockLocs[idx];
      final b = mockLocs[nextIdx];
      final currentLocation = LatLng(a.latitude * (1 - t) + b.latitude * t,
          a.longitude * (1 - t) + b.longitude * t);
      _updateLocation(currentLocation);
    });
  }

  void _initDataToStartDrive() {
    _location = Location();
    _polyLineCoordinates = [];
    _startTime = DateTime.now();
    _totalDistance = 0.0;

    _timeTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      notifyListeners();
    });
  }

  void _updateLocation(LatLng location) {
    if (_polyLineCoordinates.isNotEmpty) {
      _totalDistance +=
          Distance.twoPoints(location, _polyLineCoordinates.last).value;
    }
    _locationStreamController.add(location);
    _polyLineCoordinates.add(location);
    _currentLocation = location;
    notifyListeners();
  }
}
