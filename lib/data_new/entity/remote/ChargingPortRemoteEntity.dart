import 'package:electric_charging/data_new/models/ChargingPortModel.dart';

class ChargingPortRemoteEntity {
  ChargingPortRemoteEntity({
    required this.id,
    required this.portNumber,
    required this.status,
    required this.connectorType,
    required this.maxPower,
    required this.minimumFee,
    required this.perKwhFee,
  });

  int id;
  String portNumber;
  String status;
  String connectorType;
  double maxPower;
  double minimumFee;
  double perKwhFee;

  ChargingPortModel toModel() {
    return ChargingPortModel(
      id: id,
      portNumber: portNumber,
      status: status,
      connectorType: connectorType,
      maxPower: maxPower,
      minimumFee: minimumFee,
      perKwhFee: perKwhFee,
    );
  }

  factory ChargingPortRemoteEntity.fromJson(Map<String, dynamic> map) {
    return ChargingPortRemoteEntity(
      id: map["id"],
      portNumber: map["portNumber"],
      status: map["status"],
      connectorType: map["connectorType"],
      maxPower: map["maxPower"],
      minimumFee: map["minimumFee"],
      perKwhFee: map["perKwhFee"],
    );
  }
}
