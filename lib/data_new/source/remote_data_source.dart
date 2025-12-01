
import 'dart:convert';

import 'package:electric_charging/data_new/entity/remote/StationRemoteEntity.dart';
import 'package:electric_charging/data_new/models/StationModel.dart';
import 'package:http/http.dart' as http;

import '../utils/constaint.dart';
import 'base_source.dart';

class RemoteDataSource implements DataSource {
  @override
  Future<List<StationModel>> getListStation() async {
    final url = stationUrl;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final bodyContent = utf8.decode(response.bodyBytes); //vì có tiếng Việt
      var wrapper = jsonDecode(bodyContent) as Map;
      var list = wrapper as List;
      List<StationRemoteEntity> stations = list.map((station) => StationRemoteEntity.fromJson(station)).toList();
      var result = stations.map((station) => station.toModel()).toList();
      return result;
    } else {
      return List.empty();
    }
  }
}