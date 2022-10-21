import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/model/accident.dart';
import 'package:military_mobility_platform_frontend/model/recovery_team.dart';
import 'package:military_mobility_platform_frontend/model/reservation.dart';
import 'package:military_mobility_platform_frontend/model/mobility.dart';
import 'package:military_mobility_platform_frontend/service/api.dart';
import 'dart:io' as io;

class AccidentProvider extends ChangeNotifier {
  List<AccidentDTO> _accidentReports = [];
  int? _selectedIdxACC;
  String _accidentType = "";
  String _accidentLocation = "";
  io.File? _accidentImage;

  List<RecoveryTeamDTO> _recoveryTeamReports = [];
  int? _selectedIdxREC;
  String _recoveryTeamRequestLocation = "";
  String _recoveryTeamRequestService = "";
  String _recoveryTeamRequestNote = "";

  List<AccidentDTO> get accidentReports => _accidentReports;
  AccidentDTO? get selectedAccidentReport =>
      _selectedIdxACC != null ? _accidentReports[_selectedIdxACC!] : null;
  String get accidentType => _accidentType;
  String get accidentLocation => _accidentLocation;
  get accidentImage => _accidentImage;

  List<RecoveryTeamDTO> get recoveryTeamReports => _recoveryTeamReports;
  RecoveryTeamDTO? get selectedRecoveryTeamReport =>
      _selectedIdxREC != null ? _recoveryTeamReports[_selectedIdxREC!] : null;
  String get recoveryTeamRequestLocation => _recoveryTeamRequestLocation;
  String get recoveryTeamRequestService => _recoveryTeamRequestService;
  String get recoveryTeamRequestNote => _recoveryTeamRequestNote;

  String recoveryTeamRequestLocationGet() {
    return _recoveryTeamRequestLocation;
    notifyListeners();
  }

  void accidentTypeSet(String accidentType) {
    _accidentType = accidentType;
    notifyListeners();
  }

  void accidentLocationSet(String accidentLocation) {
    _accidentLocation = accidentLocation;
    notifyListeners();
  }

  void accidentImageSet(io.File accidentImage) {
    _accidentImage = accidentImage;
    notifyListeners();
  }

  void recoveryTeamRequestLocationSet(String recoveryTeamRequestLocation) {
    _recoveryTeamRequestLocation = recoveryTeamRequestLocation;
    notifyListeners();
  }

  void recoveryTeamRequestServiceSet(String recoveryTeamRequestService) {
    _recoveryTeamRequestService = recoveryTeamRequestService;
    notifyListeners();
  }

  void recoveryTeamRequestNoteSet(String recoveryTeamRequestNote) {
    _recoveryTeamRequestNote = recoveryTeamRequestNote;
    notifyListeners();
  }

  Future<PostAccidentRepDTO> postAccidentReport(
      Dio authClient, MobilityDTO mobility) async {
    try {
      return APIService(authClient).postAccidentReport(
          mobility.id, _accidentType, _accidentLocation, _accidentImage!);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<bool> getAccidentReport(Dio authClient) async {
    try {
      final rep = await APIService(authClient).getAccidentReport();
      _accidentReports = rep;
      notifyListeners();
      return true;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<PostRecoveryTeamDTO> postRecoveryTeam(
      Dio authClient, MobilityDTO mobility) async {
    try {
      final dto = PostRecoveryTeamReqDTO(
          car: mobility.id,
          location: _recoveryTeamRequestLocation,
          service_needs: _recoveryTeamRequestService,
          note: _recoveryTeamRequestNote);

      return APIService(authClient).postRecoveryTeam(dto);
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<bool> getRecoveryTeam(Dio authClient) async {
    try {
      final rep = await APIService(authClient).getRecoveryTeam();
      _recoveryTeamReports = rep;
      notifyListeners();
      return true;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
