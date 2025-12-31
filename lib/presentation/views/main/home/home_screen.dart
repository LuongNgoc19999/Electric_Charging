import 'package:electric_charging/data_new/models/StationModel.dart';
import 'package:electric_charging/presentation/views/main/home/home_viewmodel.dart';
import 'package:flutter/material.dart';

import 'componient/StatusItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeViewModel viewModel;
  final TextEditingController _searchController = TextEditingController();

  // Danh sách mẫu (sau có thể thay bằng dữ liệu từ API)
  final List<StationModel> _allItems = [];

  List<StationModel> _filteredItems = [];

  @override
  void initState() {
    viewModel = HomeViewModel();
    viewModel.getListStation();
    observeData();
    super.initState();
    _filteredItems = _allItems; // mặc định hiển thị tất cả
    _searchController.addListener(_onSearchChanged);
  }

  void observeData() {
    viewModel.stationModels.stream.listen((songs) {
      setState(() {
        _allItems.addAll(songs);
        _filteredItems = _allItems;
      });
    });
  }

  void _onSearchChanged() {
    final keyword = _searchController.text.toLowerCase();
    setState(() {
      _filteredItems = _allItems
          .where((item) => item.name.toLowerCase().contains(keyword))
          .toList();
    });
  }

  @override
  void dispose() {
    viewModel.stationModels.close(); //giải phóng bộ nhớ
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
                    itemBuilder: (context, index) {
                      final item = _filteredItems[index];
                      return StationItem(item: item);
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
