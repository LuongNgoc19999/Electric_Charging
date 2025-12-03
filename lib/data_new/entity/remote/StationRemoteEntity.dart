import 'package:electric_charging/data_new/models/StationModel.dart';

import 'ChargingPortRemoteEntity.dart';

class StationRemoteEntity {
  StationRemoteEntity({
    required this.id,
    // required this.createdAt,
    // required this.updatedAt,
    required this.name,
    required this.address,
    required this.city,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.isActive,
    required this.distance,
    required this.availablePorts,
    required this.totalPorts,
    required this.chargingPorts,
  });

  factory StationRemoteEntity.fromJson(Map<String, dynamic> map) {
    return StationRemoteEntity(
      id: map["id"],
      // createdAt: map["createdAt"],
      // updatedAt: map["updatedAt"],
      name: map["name"],
      address: map["address"],
      city: map["city"],
      description: map["description"],
      latitude: map["latitude"],
      longitude: map["longitude"],
      imageUrl: map["imageUrl"],
      isActive: map["isActive"],
      distance: map["distance"],
      availablePorts: map["availablePorts"],
      totalPorts: map["totalPorts"],
      chargingPorts: List<ChargingPortRemoteEntity>.from(map["chargingPorts"].map((x) => ChargingPortRemoteEntity.fromJson(x))),
    );
  }

  int id;
  // String createdAt;
  // String updatedAt;
  String name;
  String address;
  String city;
  String description;
  double latitude;
  double longitude;
  String imageUrl;
  bool isActive;
  double? distance;
  int availablePorts;
  int totalPorts;
  List<ChargingPortRemoteEntity> chargingPorts;


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StationRemoteEntity &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  StationModel toModel() {
    return StationModel(
      id: id,
      // createdAt: createdAt,
      // updatedAt: updatedAt,
      name: name,
      address: address,
      city: city,
      description: description,
      latitude: latitude,
      longitude: longitude,
      imageUrl: imageUrl,
      isActive: isActive,
      distance: distance,
      availablePorts: availablePorts,
      totalPorts: totalPorts,
      chargingPorts: chargingPorts.map((e) => e.toModel()).toList(),
    );
  }
}
