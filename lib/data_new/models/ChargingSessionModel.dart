class ChargingSessionModel {
  ChargingSessionModel({
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
}
