import 'package:electric_charging/data/models/ChargingStation.dart';
import 'package:electric_charging/presentation/views/charging_detail/ChargingDetail.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Danh sách mẫu (sau có thể thay bằng dữ liệu từ API)
  final List<ChargingStation> _allItems = ChargingStation.list();

  List<ChargingStation> _filteredItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _filteredItems = _allItems; // mặc định hiển thị tất cả
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final keyword = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems
          .where((item) => item.title.toLowerCase().contains(keyword))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tìm kiếm trạm sạc"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // 🔍 Ô tìm kiếm
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: "Nhập tên trạm sạc...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          // 📋 Danh sách kết quả
          Expanded(
            child: _filteredItems.isEmpty
                ? const Center(
              child: Text(
                "Không tìm thấy kết quả",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: _filteredItems.length,
              // separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final item = _filteredItems[index];
                return StationItem(item: item); //ListTile(
                //   leading: const Icon(
                //     Icons.ev_station,
                //     color: Colors.green,
                //   ),
                //   title: Text(item.title),
                //   subtitle: const Text("Bấm để xem chi tiết"),
                //   onTap: () {
                //     // ScaffoldMessenger.of(context).showSnackBar(
                //     //   SnackBar(content: Text("Bạn chọn: $item")),
                //     // );
                //   },
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ChargingItem extends StatelessWidget {
  final ChargingStation item;

  const ChargingItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          Stack(
            children: [
              Text(item.title),
              Align(alignment: Alignment.centerRight, child: Text("1.4 Km")),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.address),
                    Text(item.desc),
                    Text("Trống ${item.usingSocket}/${item.totalSocket}"),
                  ],
                ),
              ),
              Container(color: Colors.deepPurple, width: 56, height: 56),
            ],
          ),
          Text("đi đến map"),
        ],
      ),
    );
  }
}

class StationItem extends StatelessWidget {
  final ChargingStation item;

  const StationItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          debugPrint("Chargingdetail");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => Chargingdetail(/*user: viewModel.user!*/),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼 Ảnh tòa nhà
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),

              // 🏢 Tên tòa nhà + khoảng cách
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 18,
                      ),
                      Text(
                        '1.4 km',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // 📍 Địa chỉ
              Row(
                children: [
                  const Icon(Icons.place, color: Colors.grey, size: 18),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      item.address,
                      style: const TextStyle(color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // 📝 Mô tả
              Text(
                item.desc,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      border: Border.all(color: Colors.green, width: 1.5),
                      borderRadius: BorderRadius.circular(8), // bo góc
                    ),
                    child: Text(
                      "Trống ${item.usingSocket}/${item.totalSocket} ổ",
                      style: TextStyle(
                        color: Colors.green, // chữ xanh
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  // 🔗 Nút mở Google Map
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _openMap,
                      icon: const Icon(Icons.map, color: Colors.white),
                      label: const Text("Xem bản đồ"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openMap() async {
    // final uri = Uri.parse(mapUrl);
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri, mode: LaunchMode.externalApplication);
    // } else {
    //   debugPrint("Không thể mở bản đồ: $mapUrl");
    // }
  }
}
