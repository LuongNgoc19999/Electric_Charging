class ChargingStation {
  ChargingStation({
    required this.id,
    required this.title,
    required this.lat,
    required this.lon,
    required this.address,
    required this.totalSocket,
    required this.usingSocket,
    required this.image,
    required this.desc,
  });

  String id;
  String title;
  int lat;
  int lon;
  String address;
  int totalSocket;
  int usingSocket;
  String image;
  String desc;

static List<ChargingStation> list() {
    return [
      ChargingStation(
        id: "id",
        title: "Trạm sạc VinFast",
        lat: 0,
        lon: 0,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "image",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc TN",
        lat: 0,
        lon: 0,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "image",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc LA",
        lat: 0,
        lon: 0,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "image",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc HB",
        lat: 0,
        lon: 0,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "image",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc HCM",
        lat: 0,
        lon: 0,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "image",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc DN",
        lat: 0,
        lon: 0,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "image",
        desc: "desc",
      ),
      ChargingStation(
        id: "id",
        title: "Trạm sạc HN",
        lat: 0,
        lon: 0,
        address: "address",
        totalSocket: 40,
        usingSocket: 12,
        image: "image",
        desc: "desc",
      ),
    ];
  }
}
