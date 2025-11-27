class StationModel {
  StationModel({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.isActive,
    required this.availablePorts,
    required this.totalPorts,
  });

  int id;
  String name;
  String address;
  String city;
  String description;
  double latitude;
  double longitude;
  String imageUrl;
  bool isActive;
  int availablePorts;
  int totalPorts;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is StationModel && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

}
