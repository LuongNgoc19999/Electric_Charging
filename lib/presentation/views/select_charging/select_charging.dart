import 'package:flutter/material.dart';

import '../main/charing/charging_wave_screen.dart';

class SelectCharging extends StatefulWidget {
  const SelectCharging({super.key});

  @override
  State<SelectCharging> createState() => _SelectChargingState();
}

class _SelectChargingState extends State<SelectCharging>
    with TickerProviderStateMixin {
  int timeMinutes = 0;
  int moneyPerMinute = 200; // ví dụ: 200đ / phút
  int extraFee = 0;

  int totalPrice = 0;

  int selectedPort = 1;
  int selectedMainTab = 0; // 0: Sạc đầy, 1: Chế độ khác
  late TabController subTabController;

  @override
  void initState() {
    super.initState();
    subTabController = TabController(length: 4, vsync: this);
  }

  void calculateTotal() {
    totalPrice = (timeMinutes * moneyPerMinute) + extraFee;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),

            const SizedBox(height: 8),

            _buildPortSection(),

            const SizedBox(height: 12),

            _buildMainModeSelector(),

            _buildSubTabBar(),

            Expanded(child: _buildSubTabContent()),

            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER ------------------
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back, size: 28),
          ),
          const SizedBox(width: 10),
          const Text(
            "Sạc ngay",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ---------------- GRID CHỌN CỔNG SẠC ------------------
  Widget _buildPortSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Text(
            "CHỌN CỔNG SẠC - WGMAC2400703784",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            itemCount: 10,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (_, index) {
              int port = index + 1;
              bool isSelected = port == selectedPort;

              return GestureDetector(
                onTap: () {
                  setState(() => selectedPort = port);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green[200] : Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: isSelected
                        ? Border.all(color: Colors.green, width: 2)
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Text(
                      //   "$port",
                      //   style: const TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 14,
                      //   ),
                      // ),
                      const SizedBox(height: 4),
                      const Icon(Icons.power_outlined, size: 34),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "Sẵn sàng",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ---------------- THANH CHỌN CHẾ ĐỘ ------------------
  Widget _buildMainModeSelector() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          _buildModeButton("Sạc đầy", Icons.battery_full, 0),
          _buildModeButton("Chế độ khác", Icons.tune, 1),
        ],
      ),
    );
  }

  Widget _buildModeButton(String title, IconData icon, int index) {
    bool active = selectedMainTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedMainTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.green[200] : Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.green, size: 20),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- TAB BAR ------------------
  Widget _buildSubTabBar() {
    return TabBar(
      controller: subTabController,
      labelColor: Colors.green,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.green,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      tabs: const [
        Tab(text: "Thời gian"),
        Tab(text: "Điện năng"),
        Tab(text: "Số tiền"),
        Tab(text: "Hẹn giờ"),
      ],
    );
  }

  // ---------------- TAB NỘI DUNG ------------------
  Widget _buildSubTabContent() {
    return TabBarView(
      controller: subTabController,
      children: [
        _buildTimeOptions(),
        _buildEnergyOptions(),
        _buildMoneyOptions(),
        _buildScheduleOptions(),
      ],
    );
  }

  // ---------------- TAB: THỜI GIAN ------------------
  Widget _buildTimeOptions() {
    return _buildOptionGrid(
      title: "Nhập thời gian (phút)",
      items: ["1h", "2h", "3h", "4h", "5h", "6h"],
    );
  }

  // ---------------- TAB: ĐIỆN NĂNG ------------------
  Widget _buildEnergyOptions() {
    return _buildOptionGrid(
      title: "Nhập công suất (kWh)",
      items: ["1 kWh", "2 kWh", "3 kWh", "4 kWh", "5 kWh", "6 kWh"],
    );
  }

  // ---------------- TAB: SỐ TIỀN ------------------
  Widget _buildMoneyOptions() {
    return _buildOptionGrid(
      title: "Nhập số tiền (đ)",
      items: ["10k", "20k", "30k", "40k", "50k", "100k"],
    );
  }

  // ---------------- TAB: HẸN GIỜ ------------------
  Widget _buildScheduleOptions() {
    return Center(
      child: Text(
        "Chức năng đang phát triển",
        style: TextStyle(color: Colors.grey[600], fontSize: 16),
      ),
    );
  }

  // UI chung cho các tab
  Widget _buildOptionGrid({
    required String title,
    required List<String> items,
  }) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: title,
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: items
                .map(
                  (e) => Container(
                    width: 90,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  // ---------------- BOTTOM BUTTON ------------------
  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.local_offer, color: Colors.green),
          const SizedBox(width: 4),
          const Text("Mã giảm giá", style: TextStyle(fontSize: 14)),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ChargingWaveScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Text(
                "Bắt đầu sạc",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
