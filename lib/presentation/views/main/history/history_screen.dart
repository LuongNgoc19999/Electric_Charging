import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String selectedFilter = "week";

  final List<Map<String, dynamic>> history = [
    {
      "start": DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      "end": DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      "energy": 1.8, // kWh
      "cost": 6500,
    },
    {
      "start": DateTime.now().subtract(const Duration(days: 2, hours: 5)),
      "end": DateTime.now().subtract(const Duration(days: 2, hours: 3)),
      "energy": 2.3,
      "cost": 8200,
    },
    {
      "start": DateTime.now().subtract(const Duration(days: 5)),
      "end": DateTime.now().subtract(const Duration(days: 5, hours: -2)),
      "energy": 1.2,
      "cost": 4300,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredList = _getFilteredList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử sạc xe"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 🔘 Bộ lọc tuần / tháng
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildFilterButton("week", "Tuần này"),
                const SizedBox(width: 12),
                _buildFilterButton("month", "Tháng này"),
              ],
            ),
          ),

          // 📊 Tổng kết nhanh
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _buildSummary(filteredList),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // 📋 Danh sách lịch sử sạc
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final item = filteredList[index];
                return _buildHistoryItem(item);
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Bộ lọc tuần / tháng
  Widget _buildFilterButton(String key, String label) {
    final isActive = selectedFilter == key;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedFilter = key),
        child: Container(
          height: 40,
          decoration: BoxDecoration(
            color: isActive ? Colors.blueAccent : Colors.white,
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Mỗi item trong danh sách
  Widget _buildHistoryItem(Map<String, dynamic> item) {
    // final start = DateFormat('HH:mm dd/MM').format(item["start"]);
    // final end = DateFormat('HH:mm dd/MM').format(item["end"]);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: const Icon(Icons.ev_station, color: Colors.green, size: 32),
        title: Text("Bắt đầu: 16:00 20/10/2025"),
        subtitle: Text("Kết thúc: 17:00 20/10/2025\nNăng lượng: ${item["energy"]} kWh"),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${item["cost"].toStringAsFixed(0)} đ",
              style: const TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Thống kê tổng
  Widget _buildSummary(List<Map<String, dynamic>> list) {
    final totalEnergy =
    list.fold(0.0, (sum, e) => sum + (e["energy"] as double));
    final totalCost = list.fold(0, (sum, e) => sum + (e["cost"] as int));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tổng kết",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Tổng năng lượng: ${totalEnergy.toStringAsFixed(1)} kWh"),
            Text("Chi phí: 100.000 đ"),
          ],
        ),
      ],
    );
  }

  // 🔹 Lọc theo tuần / tháng
  List<Map<String, dynamic>> _getFilteredList() {
    final now = DateTime.now();
    if (selectedFilter == "week") {
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
      return history
          .where((item) => item["start"].isAfter(startOfWeek))
          .toList();
    } else {
      final startOfMonth = DateTime(now.year, now.month, 1);
      return history
          .where((item) => item["start"].isAfter(startOfMonth))
          .toList();
    }
  }
}