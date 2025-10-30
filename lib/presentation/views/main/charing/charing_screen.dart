import 'package:flutter/material.dart';

class CharingScreen extends StatefulWidget {
  const CharingScreen({super.key});

  @override
  State<CharingScreen> createState() => _CharingScreenState();
}

class _CharingScreenState extends State<CharingScreen> {
  double batteryLevel = 0.68; // 68%
  bool isCharging = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Theo dõi tình trạng sạc"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // 🔋 Icon pin lớn
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 180,
                  width: 180,
                  child: CircularProgressIndicator(
                    value: batteryLevel,
                    strokeWidth: 14,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(
                      batteryLevel >= 1.0
                          ? Colors.green
                          : isCharging
                          ? Colors.blue
                          : Colors.orange,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Icon(
                      isCharging ? Icons.bolt : Icons.battery_full,
                      size: 48,
                      color: isCharging
                          ? Colors.blueAccent
                          : Colors.greenAccent,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${(batteryLevel * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ⚡ Trạng thái sạc
            Text(
              isCharging
                  ? (batteryLevel >= 1.0
                  ? "Đã sạc đầy"
                  : "Đang sạc...")
                  : "Đang sử dụng",
              style: TextStyle(
                fontSize: 18,
                color: isCharging
                    ? Colors.blueAccent
                    : Colors.orangeAccent,
              ),
            ),

            const SizedBox(height: 20),

            // 📊 Thanh hiển thị pin chi tiết
            Container(
              height: 30,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: batteryLevel,
                    child: Container(
                      decoration: BoxDecoration(
                        color: batteryLevel >= 1.0
                            ? Colors.green
                            : Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ⏱️ Thông tin chi tiết
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow("Tình trạng pin", isCharging ? "Đang sạc" : "Đang sử dụng"),
                    _infoRow("Dung lượng pin", "${(batteryLevel * 100).toStringAsFixed(0)}%"),
                    _infoRow("Thời gian còn lại", isCharging ? "≈ 1 giờ 20 phút" : "-"),
                    _infoRow("Điện áp sạc", "54.6 V"),
                    _infoRow("Dòng điện", "1.8 A"),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // 🔘 Nút mô phỏng thay đổi trạng thái
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text("Cập nhật trạng thái"),
              onPressed: () {
                setState(() {
                  batteryLevel += 0.1;
                  if (batteryLevel > 1.0) batteryLevel = 1.0;
                });
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 15)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
