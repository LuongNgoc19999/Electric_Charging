
class ChargingSocket {
  final String id;
  final double powerKw;
  final bool isAvailable;
  final double price;

  ChargingSocket({
    required this.id,
    required this.powerKw,
    required this.isAvailable,
    required this.price,
  });
}