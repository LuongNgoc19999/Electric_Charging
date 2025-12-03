import 'dart:convert';

import 'package:electric_charging/data_new/entity/remote/ChargingSessionRemoteEntity.dart';
import 'package:electric_charging/data_new/entity/remote/StationRemoteEntity.dart';
import 'package:electric_charging/data_new/models/ChargingSessionModel.dart';
import 'package:electric_charging/data_new/models/StationModel.dart';
import 'package:flutter/cupertino.dart';
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
      debugPrint("ngoc, response: ${response.body}");
      final bodyContent = utf8.decode(response.bodyBytes); //vì có tiếng Việt
      final List data = jsonDecode(bodyContent);
      List<StationRemoteEntity> stations = data
          .map((e) => StationRemoteEntity.fromJson(e))
          .toList();
      var result = stations.map((station) => station.toModel()).toList();
      return result;
    } else {
      return List.empty();
    }
  }

  @override
  Future<List<ChargingSessionModel>> getListSession() async {
    final url = sessionUrl;
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      debugPrint("ngoc, response: ${response.body}");
      final bodyContent = utf8.decode(response.bodyBytes); //vì có tiếng Việt
      final List data = jsonDecode(bodyContent);
      List<ChargingSessionRemoteEntity> sessions = data
          .map((e) => ChargingSessionRemoteEntity.fromJson(e))
          .toList();
      var result = sessions.map((session) => session.toModel()).toList();
      return result;
    } else {
      return List.empty();
    }
  }
}
