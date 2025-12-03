import 'package:electric_charging/data_new/models/StationModel.dart';
import 'package:flutter/material.dart';

import '../source/remote_data_source.dart';

abstract interface class ChargingRepository {
  Future<List<StationModel>> getListStation();
}
class ChargingRepositoryImpl implements ChargingRepository{
  final _remoteDataSource = RemoteDataSource();

  @override
  Future<List<StationModel>> getListStation() async {
    List<StationModel> result = await _remoteDataSource.getListStation();
    debugPrint("ngoc, result: "+result.toString());
    return result;
  }

}