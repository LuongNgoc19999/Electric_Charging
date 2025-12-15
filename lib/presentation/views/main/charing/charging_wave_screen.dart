import 'package:flutter/material.dart';

import 'componient/wave_widget.dart';

class ChargingWaveScreen extends StatelessWidget {
  const ChargingWaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            const SizedBox(height: 16),

            buildChargingCircle(),

            const SizedBox(height: 20),

            _buildInfoBox(),

            const Spacer(),

            _buildStopButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, size: 30, color: Colors.green)
          ),
          Text(
            "Đang sạc",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Icon(Icons.warning_amber_rounded, size: 30, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _infoRow("Tên trụ", "WGMAC2400703784"),
          _infoRow("Mã trụ", "868371077003784"),
          _infoRow("Mã giao dịch", "19685-64F1"),
          _infoRow("Cổng sạc số", "1"),
          _infoRow("Thời gian đã sạc (phút)", "0,0"),
          _infoRow("Điện năng đã sạc (Wh)", "0"),
          Divider(),
          _infoRow("Tổng số tiền (VND)", "0", bold: true),
        ],
      ),
    );
  }

  Widget _buildStopButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        onPressed: () {},
        child: const Text(
          "Dừng sạc",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}

class _infoRow extends StatelessWidget {
  final String title;
  final String value;
  final bool bold;

  const _infoRow(this.title, this.value, {this.bold = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 16)),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
