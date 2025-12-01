import 'dart:async';

import 'package:electric_charging/data_new/repository/charging_repository.dart';

import '../../../../data_new/models/StationModel.dart';

class HomeViewModel {
  StreamController<List<StationModel>> stationModels = StreamController();

  void getListStation() {
    final repository = ChargingRepositoryImpl();
    repository.getListStation().then((value) {
      stationModels.add(value);
    });
  }
}