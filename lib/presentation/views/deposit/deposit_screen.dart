import 'package:flutter/material.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> { final TextEditingController moneyController = TextEditingController(text: "0");
int selectedMethod = 0;

final List<int> quickValues = [
  50000,
  100000,
  200000,
  300000,
  500000,
  1000000,
];

@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: const Color(0xFFF8FFE8),
    resizeToAvoidBottomInset: true,
    body: SafeArea(
      child: Column(
        children: [
          _buildHeader(),
          Expanded(child: _buildBody()),
          _buildBottomButton(),
        ],
      ),
    ),
  );
}

// ============================================================
// HEADER
// ============================================================
Widget _buildHeader() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, size: 26),
        ),
        const SizedBox(width: 12),
        const Text(
          "Nạp tiền",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

// ============================================================
// BODY (Scroll)
// ============================================================
Widget _buildBody() {
  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBalanceCard(),
        const SizedBox(height: 20),
        _buildQuickSelect(),
        const SizedBox(height: 20),
        _buildPaymentMethod(),
        const SizedBox(height: 150),
      ],
    ),
  );
}

// ============================================================
// Balance Card
// ============================================================
Widget _buildBalanceCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black12.withOpacity(0.05),
          blurRadius: 6,
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.wallet, size: 50, color: Colors.green.shade700), // icon ví
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Số dư", style: TextStyle(fontSize: 16)),
            SizedBox(height: 4),
            Text(
              "0 (VND)",
              style: TextStyle(
                color: Colors.green,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      ],
    ),
  );
}

// ============================================================
// Quick Select Money
// ============================================================
Widget _buildQuickSelect() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Chọn nhanh (VND)",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: quickValues.map((value) {
            return GestureDetector(
              onTap: () {
                moneyController.text = value.toString();
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Text(
                  "${value ~/ 1000}.000",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        // TextField nhập số tiền
        TextField(
          controller: moneyController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "0",
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(22),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// PAYMENT METHOD
// ============================================================
Widget _buildPaymentMethod() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Phương thức thanh toán",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        const SizedBox(height: 14),

        Row(
          children: [
            Icon(Icons.qr_code, size: 28,),
            const SizedBox(width: 12),
            const Text("Mã QR", style: TextStyle(fontSize: 16)),
            const Spacer(),
            GestureDetector(
              onTap: () {
                selectedMethod = 0;
                setState(() {});
              },
              child: Icon(
                Icons.radio_button_checked,
                color: Colors.green,
                size: 28,
              ),
            )
          ],
        )
      ],
    ),
  );
}

// ============================================================
// BOTTOM BUTTON
// ============================================================
Widget _buildBottomButton() {
  return Container(
    padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
    color: Colors.transparent,
    child: Container(
      height: 52,
      decoration: BoxDecoration(
        color: const Color(0xFFB7EB8F),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Center(
        child: Text(
          "Nạp tiền",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}
}
