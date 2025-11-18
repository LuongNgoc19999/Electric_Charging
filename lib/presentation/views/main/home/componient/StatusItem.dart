
import 'package:flutter/material.dart';

import '../../../../../data/models/ChargingStation.dart';
import '../../../charging_detail/StationDetail.dart';

class StationItem extends StatelessWidget {
  final ChargingStation item;

  const StationItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          debugPrint("Chargingdetail");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => StationDetailScreen(/*user: viewModel.user!*/),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🖼 Ảnh tòa nhà
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  item.image,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),

              // 🏢 Tên tòa nhà + khoảng cách
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 18,
                      ),
                      Text(
                        '1.4 km',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // 📍 Địa chỉ
              Row(
                children: [
                  const Icon(Icons.place, color: Colors.grey, size: 18),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      item.address,
                      style: const TextStyle(color: Colors.black87),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // 📝 Mô tả
              Text(
                item.desc,
                style: const TextStyle(color: Colors.grey, fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      border: Border.all(color: Colors.green, width: 1.5),
                      borderRadius: BorderRadius.circular(8), // bo góc
                    ),
                    child: Text(
                      "Trống ${item.usingSocket}/${item.totalSocket} ổ",
                      style: TextStyle(
                        color: Colors.green, // chữ xanh
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  // 🔗 Nút mở Google Map
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _openMap,
                      icon: const Icon(Icons.map, color: Colors.white),
                      label: const Text("Xem bản đồ"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openMap() async {
    // final uri = Uri.parse(mapUrl);
    // if (await canLaunchUrl(uri)) {
    //   await launchUrl(uri, mode: LaunchMode.externalApplication);
    // } else {
    //   debugPrint("Không thể mở bản đồ: $mapUrl");
    // }
  }
}
