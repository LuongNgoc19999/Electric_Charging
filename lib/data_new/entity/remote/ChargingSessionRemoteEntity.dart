import 'package:electric_charging/data_new/models/ChargingSessionModel.dart';

class ChargingSessionRemoteEntity {
  ChargingSessionRemoteEntity({
    required this.id,
    required this.userId,
    required this.chargingPortId,
    required this.vehicleId,
    required this.stationName,
    required this.portNumber,
    required this.startTime,
    required this.endTime,
    required this.energyDelivered,
    required this.totalCost,
    required this.status,
    required this.startBatteryPercentage,
    required this.endBatteryPercentage,
  });

  factory ChargingSessionRemoteEntity.fromJson(Map<String, dynamic> map) {
    return ChargingSessionRemoteEntity(
      id: map["id"],
      userId: map["userId"],
      chargingPortId: map["chargingPortId"],
      vehicleId: map["vehicleId"],
      stationName: map["stationName"],
      portNumber: map["portNumber"],
      startTime: map["startTime"],
      endTime: map["endTime"],
      energyDelivered: map["energyDelivered"],
      totalCost: map["totalCost"],
      status: map["status"],
      startBatteryPercentage: map["startBatteryPercentage"],
      endBatteryPercentage: map["endBatteryPercentage"],
    );
  }
  int id;
  int userId;
  int chargingPortId;
  int vehicleId;
  String stationName;
  String portNumber;
  String startTime;
  String endTime;
  int energyDelivered;
  int totalCost;
  String status;
  int startBatteryPercentage;
  int endBatteryPercentage;


  ChargingSessionModel toModel() {
    return ChargingSessionModel(
      id: id,
      userId: userId,
      chargingPortId: chargingPortId,
      vehicleId: vehicleId,
      stationName: stationName,
      portNumber: portNumber,
      startTime: startTime,
      endTime: endTime,
      energyDelivered: energyDelivered,
      totalCost: totalCost,
      status: status,
      startBatteryPercentage: startBatteryPercentage,
      endBatteryPercentage: endBatteryPercentage,
    );
  }

}
