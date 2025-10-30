import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isScanned = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Quét mã QR"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // 🔍 Camera quét QR
          MobileScanner(
            onDetect: (capture) {
              if (isScanned) return; // tránh quét lặp lại
              final List<Barcode> barcodes = capture.barcodes;
              final Barcode barcode = barcodes.first;
              final String? code = barcode.rawValue;

              if (code != null) {
                setState(() => isScanned = true);
                _showResultDialog(code);
              }
            },
          ),

          // 🎯 Khung định vị QR
          Center(
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent, width: 3),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),

          // 📝 Hướng dẫn
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Text(
                "Đưa mã QR vào khung để quét",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
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