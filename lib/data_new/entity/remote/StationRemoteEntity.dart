import 'package:electric_charging/data_new/models/StationModel.dart';

class StationRemoteEntity {
  StationRemoteEntity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.address,
    required this.city,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.isActive,
    required this.availablePorts,
  });

  factory StationRemoteEntity.fromJson(Map<String, dynamic> map) {
    return StationRemoteEntity(
      id: map["id"],
      createdAt: map["createdAt"],
      updatedAt: map["updatedAt"],
      name: map["name"],
      address: map["address"],
      city: map["city"],
      description: map["description"],
      latitude: map["latitude"],
      longitude: map["longitude"],
      imageUrl: map["imageUrl"],
      isActive: map["isActive"],
      availablePorts: map["availablePorts"],
    );
  }

  int id;
  String createdAt;
  String updatedAt;
  String name;
  String address;
  String city;
  String description;
  double latitude;
  double longitude;
  String imageUrl;
  bool isActive;
  int availablePorts;

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
      createdAt: createdAt,
      updatedAt: updatedAt,
      name: name,
      address: address,
      city: city,
      description: description,
      latitude: latitude,
      longitude: longitude,
      imageUrl: imageUrl,
      isActive: isActive,
      availablePorts: availablePorts,
    );
  }
}
