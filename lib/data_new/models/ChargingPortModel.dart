class ChargingPortModel {
  ChargingPortModel({
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
}
