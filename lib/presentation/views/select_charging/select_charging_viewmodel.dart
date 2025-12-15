import 'dart:async';

import 'package:electric_charging/data_new/repository/charging_repository.dart';

import '../../../../data_new/models/StationModel.dart';
import '../../../data_new/models/ChargingPortModel.dart';


class SelectChargingViewmodel {
  StreamController<List<ChargingPortModel>> ports = StreamController();

  void getListNode() {
    final repository = ChargingRepositoryImpl();
    // repository.getListStation().then((value) {
    //   ports.add(value);
    // });
  }
}