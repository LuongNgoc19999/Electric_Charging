import 'package:flutter/material.dart';

class Chargingdetail extends StatefulWidget {
  final List<ChargingSocket> sockets = [
  ChargingSocket(id: '1', powerKw: 22, isAvailable: true),
  ChargingSocket(id: '2', powerKw: 11, isAvailable: false),
  ChargingSocket(id: '3', powerKw: 7.4, isAvailable: true),
  ];
  Chargingdetail({super.key});

  @override
  State<Chargingdetail> createState() => _ChargingdetailState();
}

class _ChargingdetailState extends State<Chargingdetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trạm sạc X"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: widget.sockets.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final socket = widget.sockets[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: ListTile(
              leading: Icon(
                Icons.ev_station,
                color: socket.isAvailable ? Colors.green : Colors.grey,
                size: 36,
              ),
              title: Text(
                'Ổ sạc #${socket.id}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${socket.powerKw} kW'),
              trailing: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: socket.isAvailable ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  socket.isAvailable ? 'Còn trống' : 'Đang sạc',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChargingSocket {
  final String id;
  final double powerKw;
  final bool isAvailable;

  ChargingSocket({
    required this.id,
    required this.powerKw,
    required this.isAvailable,
  });
}