import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin DeviceStorageMixin {
  DeviceStorageUtil deviceStorageUtil = Get.find<DeviceStorageUtil>();
}

class DeviceStorageUtil {
  // static AndroidDeviceInfo? androidDeviceInfo;

  Future<void> saveData(String key, value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, json.encode(value));
    } catch (e, stackTrace) {
    }
  }

  dynamic readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    if (value == null || value.isEmpty) {
      return null;
    } else {
      return json.decode(value);
    }
  }

  Future<void> removeData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static checkValueKey(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static setIntValue(String key, int n) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, n);
  }

  static getIntValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static setStringValue(String key, String s) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, s);
  }

  static getStringValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static removeStringValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static setBooleanValue(String key, bool b) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, b);
  }

  static getBooleanValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
