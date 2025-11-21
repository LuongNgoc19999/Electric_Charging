import 'package:electric_charging/presentation/views/select_charging/select_charging.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isScanned = false;
  final MobileScannerController cameraController = MobileScannerController();

  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Quét mã QR"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const SizedBox(height: 60),

          // 🟩 Camera hiển thị ở giữa
          Center(
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.green, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: MobileScanner(
                  controller: cameraController,
                  // allowDuplicates: false,
                  onDetect: (barcodeCapture) {
                    final barcode = barcodeCapture.barcodes.first;
                    final String? code = barcode.rawValue;

                    if (code == null || isScanned) return;

                    setState(() => isScanned = true);

                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Đã quét: $code')));

                    // TODO: xử lý dữ liệu QR ở đây
                  },
                ),
              ),
            ),
          ),

          const SizedBox(height: 40),

          // 🔘 Nút bật/tắt flash và camera
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.flash_on, color: Colors.green),
                onPressed: () => cameraController.toggleTorch(),
              ),
              const SizedBox(width: 20),
              IconButton(
                icon: const Icon(Icons.cameraswitch, color: Colors.green),
                onPressed: () => cameraController.switchCamera(),
              ),
            ],
          ),

          const SizedBox(height: 20),

          const Text(
            "Đặt mã QR vào khung để quét",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SelectCharging()),
              );
            },
            child: Icon(Icons.qr_code, size: 64),
          ),
        ],
      ),
    );
  }

  void _showResultDialog(String code) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Đã quét mã thành công!"),
        content: Text("Nội dung mã QR:\n$code"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => isScanned = false);
            },
            child: const Text("Quét lại"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context, code); // trả về code cho màn trước
            },
            child: const Text("Xong"),
          ),
        ],
      ),
    );
  }
}
