import 'package:flutter/material.dart';

class StationDetailScreen extends StatelessWidget {
  const StationDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chargers = [
      {'name': 'Cổng sạc 1', 'status': 'Trống', 'minFee': '4,900 VND', 'price': '8.9 VND/Wh'},
      {'name': 'Cổng sạc 2', 'status': 'Trống', 'minFee': '4,900 VND', 'price': '8.9 VND/Wh'},
      {'name': 'Cổng sạc 1', 'status': 'Trống', 'minFee': '4,900 VND', 'price': '8.9 VND/Wh'},
      {'name': 'Cổng sạc 2', 'status': 'Trống', 'minFee': '4,900 VND', 'price': '8.9 VND/Wh'},
      {'name': 'Cổng sạc 1', 'status': 'Trống', 'minFee': '4,900 VND', 'price': '8.9 VND/Wh'},
      {'name': 'Cổng sạc 2', 'status': 'Trống', 'minFee': '4,900 VND', 'price': '8.9 VND/Wh'},
      {'name': 'Cổng sạc 1', 'status': 'Trống', 'minFee': '4,900 VND', 'price': '8.9 VND/Wh'},
      {'name': 'Cổng sạc 2', 'status': 'Trống', 'minFee': '4,900 VND', 'price': '8.9 VND/Wh'},
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.green,
            expandedHeight: 220,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://tl.cdnchinhphu.vn/344445545208135680/2023/7/4/b80ecce260c7b099e9d6-16884694045491028269359.jpg",
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          ),

          // Nội dung chính
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Trạng thái và khoảng cách
                  Row(
                    children: [
                      const Icon(Icons.ev_station, color: Colors.green),
                      const SizedBox(width: 6),
                      const Text('TRỐNG', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('1.9 km', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Tên trạm
                  const Text(
                    'CHUNG CƯ HẢI ĐĂNG CT1',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),

                  // Địa chỉ
                  const Text(
                    'Nguyễn Cơ Thạch, Mỹ Đình, Nam Từ Liêm, Hà Nội',
                    style: TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 8),

                  // Cách tìm trạm
                  const Text('Cách tìm trạm sạc:', style: TextStyle(fontWeight: FontWeight.bold)),
                  const Text('Bãi đậu xe tòa nhà'),
                  const SizedBox(height: 12),

                  // Thống kê cổng sạc
                  Row(
                    children: const [
                      Icon(Icons.check_circle, color: Colors.green),
                      SizedBox(width: 4),
                      Text('6 Cổng sạc'),
                      SizedBox(width: 16),
                      Icon(Icons.cancel, color: Colors.red),
                      SizedBox(width: 4),
                      Text('2 Cổng sạc'),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const Text('CỔNG SẠC', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),

                  // Danh sách cổng sạc
                  ...chargers.map((item) => _buildChargerCard(item)).toList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildChargerCard(Map<String, String> charger) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon ổ sạc
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.electrical_services, color: Colors.black54),
          ),

          const SizedBox(width: 12),

          // Phần thông tin
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tên cổng
                Text(
                  charger['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),

                // Trạng thái
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green),
                  ),
                  child: Text(
                    charger['status']!,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Hai cột phí
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Phí tối thiểu',
                            style: TextStyle(fontSize: 12, color: Colors.black54)),
                        Text(
                          charger['minFee']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black87),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Phí sạc',
                            style: TextStyle(fontSize: 12, color: Colors.black54)),
                        Text(
                          charger['price']!,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black87),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
