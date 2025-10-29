import 'package:electric_charging/data/models/ChargingStation.dart';
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
                : ListView.separated(
                    itemCount: _filteredItems.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return ChargingItem(item: item); //ListTile(
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
