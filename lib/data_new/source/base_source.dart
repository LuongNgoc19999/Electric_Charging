
import 'package:electric_charging/data_new/models/ChargingSessionModel.dart';
import 'package:electric_charging/data_new/models/StationModel.dart';

abstract interface class DataSource {
  Future<List<StationModel>> getListStation();
  Future<List<ChargingSessionModel>> getListSession();
}