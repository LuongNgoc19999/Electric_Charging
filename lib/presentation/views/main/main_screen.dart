import 'package:electric_charging/presentation/views/main/charing/charing_screen.dart';
import 'package:electric_charging/presentation/views/main/history/history_screen.dart';
import 'package:electric_charging/presentation/views/main/home/home_screen.dart';
import 'package:electric_charging/presentation/views/main/personal/personal_screen.dart';
import 'package:electric_charging/presentation/views/scan/scan_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  // final User user;

  const MainScreen({super.key /*required this.user*/});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final List<String> _titles = ['Trang chủ', 'Sạc', 'Lịch sử', 'Tài khoản'];
  final List<IconData> _icons = [
    Icons.home,
    Icons.electric_scooter,
    Icons.history,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // ✅ PageView để chuyển trang
      body:
          // SafeArea(
          //   child:
          PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _selectedIndex = index),
            children: const [
              HomeScreen(),
              CharingScreen(),
              HistoryScreen(),
              PersonalScreen(),
            ],
          ),
      // ),

      // ✅ Nút tròn giữa (FAB)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("Bấm nút giữa");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ScanScreen(/*user: viewModel.user!*/),
            ),
          );
        },
        backgroundColor: Colors.green,
        shape: const CircleBorder(),
        child: const Icon(Icons.qr_code, color: Colors.white, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // ✅ Bottom Navigation tùy chỉnh
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        // child: Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(0),
            _buildNavItem(1),
            const SizedBox(width: 40), // chừa chỗ cho FAB
            _buildNavItem(2),
            _buildNavItem(3),
          ],
        ),
        // ),
      ),
    );
  }

  // ✅ Tạo từng item trong bottom nav
  Widget _buildNavItem(int index) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? Colors.green : Colors.grey.shade400;

    return GestureDetector(
      onTap: () {
        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icons[index], color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            _titles[index],
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
