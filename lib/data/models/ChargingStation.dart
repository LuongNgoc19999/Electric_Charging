import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChargingStation {
  ChargingStation({
    required this.id,
    required this.title,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.totalSocket,
    required this.usingSocket,
    required this.image,
    required this.desc,
  });

  String id;
  String title;
  double latitude;
  double longitude;
  String address;
  int totalSocket;
  int usingSocket;
  String image;
  String desc;
  LatLng getLatLon(){
    return LatLng(latitude, longitude);
  }
static List<ChargingStation> list() {
    return [
      ChargingStation(
        id: "id",
        title: "Trạm sạc Chùa Một Cột",
        latitude: 21.0358327,
        longitude: 105.8310457,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "https://tl.cdnchinhphu.vn/344445545208135680/2023/7/4/b80ecce260c7b099e9d6-16884694045491028269359.jpg",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc Lăng Bác",
        latitude: 21.0368973,
        longitude: 105.8333792,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "https://tl.cdnchinhphu.vn/344445545208135680/2023/7/4/b80ecce260c7b099e9d6-16884694045491028269359.jpg",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc Hồ Tùng Mậu",
        latitude: 21.0389477,
        longitude: 105.7752996,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "https://tl.cdnchinhphu.vn/344445545208135680/2023/7/4/b80ecce260c7b099e9d6-16884694045491028269359.jpg",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc Lê Đức Thọ",
        latitude: 21.0309513,
        longitude: 105.7680624,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "https://tl.cdnchinhphu.vn/344445545208135680/2023/7/4/b80ecce260c7b099e9d6-16884694045491028269359.jpg",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc Mỹ Đình",
        latitude: 21.0203492,
        longitude: 105.7635814,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "https://tl.cdnchinhphu.vn/344445545208135680/2023/7/4/b80ecce260c7b099e9d6-16884694045491028269359.jpg",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc Xuân Phương",
        latitude: 21.0096754,
        longitude: 105.75294,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "https://tl.cdnchinhphu.vn/344445545208135680/2023/7/4/b80ecce260c7b099e9d6-16884694045491028269359.jpg",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc Công Nghiệp",
        latitude: 21.0436244,
        longitude: 105.7345722,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "https://tl.cdnchinhphu.vn/344445545208135680/2023/7/4/b80ecce260c7b099e9d6-16884694045491028269359.jpg",
        desc: "desc",
      ),
    ];
  }
}
