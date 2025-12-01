
import 'package:electric_charging/data_new/models/StationModel.dart';
import 'package:flutter/material.dart';

import '../../../../../data/models/ChargingStation.dart';
import '../../../charging_detail/StationDetail.dart';

class StationItem extends StatelessWidget {

  final StationModel item;
  // final String status;
  // final String imagePath;
  // final String title;
  // final String address;
  // final int slot;
  // final String power;
  // final String distance;

  const StationItem({
    super.key,
    required this.item,
    // required this.status,
    // required this.imagePath,
    // required this.title,
    // required this.address,
    // required this.slot,
    // required this.power,
    // required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 3),
          )
        ],
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StationDetailScreen(/*user: viewModel.user!*/),
            ),
          );
        },
        child: Row(
        children: [
          // image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  item.imageUrl,
                  width: 110,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Color(0xFF8CE260),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Free",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),

          const SizedBox(width: 12),

          // info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 4),

                Text(
                  item.address,
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey.shade700),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [
                    _info(Icons.ev_station, ""/*"${item.usingSocket}/${item.totalSocket}"*/),
                    SizedBox(width: 10),
                    _info(Icons.bolt, "7W"),
                    SizedBox(width: 10),
                    _info(Icons.place, "7 Km"),
                  ],
                )
              ],
            ),
          ),

          // navigate icon
          Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Color(0xFFE9FAD7),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.navigation, size: 20, color: Colors.green),
          )
        ],
      ),
      )
    );
  }

  Widget _info(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey.shade700),
        SizedBox(width: 4),
        Text(text, style: TextStyle(fontSize: 13)),
      ],
    );
  }
}
