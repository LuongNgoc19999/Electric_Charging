import 'package:flutter/material.dart';

import '../../deposit/deposit_screen.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Giả lập dữ liệu người dùng
    final user = {
      "name": "Nguyễn Văn A",
      "avatarUrl": "https://i.pravatar.cc/150?img=3",
      "balance": 153200,
      "email": "nguyenvana@gmail.com",
      "vehicle": "Xe điện VinFast Evo200",
    };

    return Scaffold(
      appBar: AppBar(title: const Text("Tài khoản của tôi"), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            Icon(Icons.person),
            // 🧍 Avatar + tên người dùng
            // CircleAvatar(
            //   radius: 50,
            //   backgroundImage: Icon(Icons.person),
            // ),
            const SizedBox(height: 12),
            Text(
              "Lương Hữu Ngọc",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text("ngoc@gmail.com", style: TextStyle(color: Colors.grey[600])),

            const SizedBox(height: 24),

            // 💰 Số dư tài khoản
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Số dư tài khoản",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1.000.000.000 đ",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text("Nạp tiền"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => DepositScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🧾 Thông tin khác
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _infoItem(
                    Icons.electric_scooter,
                    "Phương tiện",
                    "Vinfast VF8",
                  ),
                  _infoItem(
                    Icons.history,
                    "Lịch sử giao dịch",
                    "Xem chi tiết",
                    onTap: () {
                      // TODO: Điều hướng sang lịch sử giao dịch
                    },
                  ),
                  _infoItem(
                    Icons.settings,
                    "Cài đặt",
                    "Tùy chỉnh tài khoản",
                    onTap: () {
                      // TODO: Mở trang cài đặt
                    },
                  ),
                  _infoItem(
                    Icons.logout,
                    "Đăng xuất",
                    "Thoát khỏi tài khoản",
                    onTap: () {
                      // TODO: Xử lý logout
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(
    IconData icon,
    String title,
    String subtitle, {
    VoidCallback? onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
