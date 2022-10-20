import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/constatns/locations.dart';
import 'package:military_mobility_platform_frontend/model/mobility.dart';
import 'package:military_mobility_platform_frontend/model/reservation.dart';
import 'package:military_mobility_platform_frontend/service/api.dart';

class MobilityRequestProvider extends ChangeNotifier {
  MobilityRequestProvider() {
    const kInterval = 15;
    final now = DateTime.now();
    _departureTime = now.subtract(Duration(minutes: now.minute % kInterval));
    if (now.minute % 15 != 0) {
      _departureTime = _departureTime.add(const Duration(minutes: kInterval));
    }
    _arrivalTime = _departureTime.add(const Duration(days: 1));
  }

  String _departure = kLocations[0];
  String _destination = kLocations[0];
  int _passengers = 1;
  late DateTime _departureTime;
  late DateTime _arrivalTime;
  List<MobilityDTO> _availableMobilities = [];

  String get departure => _departure;
  String get destination => _destination;
  int get passengers => _passengers;
  DateTime get departureTime => _departureTime;
  DateTime get arrivalTime => _arrivalTime;
  List<MobilityDTO> get availableMobilities => _availableMobilities;

  void setLocations({String? departure, String? destination}) {
    _departure = departure ?? _departure;
    _destination = destination ?? _destination;
    notifyListeners();
  }

  void increasePassengers() {
    _passengers += 1;
    notifyListeners();
  }

  void decreasePassengers() {
    _passengers = max(1, _passengers - 1);
    notifyListeners();
  }

  void setDepartureTime(DateTime val) {
    _departureTime = val;
    notifyListeners();
  }

  void setArrivalTime(DateTime val) {
    _arrivalTime = val;
    notifyListeners();
  }

  Future<void> getAvailableMobilities(Dio authClient) async {
    try {
      final dto = GetAvailableMobilitiesReqDTO(
          passengers: _passengers,
          departureTime: _departureTime,
          arrivalTime: _arrivalTime);
      final response = await APIService(authClient).getAvailableMobilities(dto);
      _availableMobilities = response;
      notifyListeners();
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<MakeReservationResDTO> makeReservation(
      Dio authClient, MobilityDTO mobility) async {
    try {
      final dto = MakeReservationReqDTO(
          carID: mobility.id,
          departure: departure,
          destination: destination,
          startTime: _departureTime,
          endTime: _arrivalTime);
      return APIService(authClient).makeReservation(dto);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
