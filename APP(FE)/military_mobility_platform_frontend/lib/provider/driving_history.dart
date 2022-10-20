import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:military_mobility_platform_frontend/model/mileage.dart';
import 'package:military_mobility_platform_frontend/service/api.dart';

class DrivingHistoryProvider extends ChangeNotifier {
  List<HistoryDTO> _histories = [];

  List<HistoryDTO> get histories => _histories;

  Future<bool> getHistories(Dio authClient) async {
    try {
      final res = await APIService(authClient).getHistories();
      _histories = res;
      notifyListeners();
      return true;
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
