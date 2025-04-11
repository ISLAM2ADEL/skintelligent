import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

//! Here The Initialize of cache .
  init() async {
    prefs = await SharedPreferences.getInstance();
  }

  String? getDataString({required String key}) {
    return prefs.getString(key);
  }

//! this method to put data in local database using key

  Future saveData({required String key, required dynamic value}) async {
    if (value is bool) {
      return await prefs.setBool(key, value);
    }

    if (value is String) {
      return await prefs.setString(key, value);
    }

    if (value is int) {
      return await prefs.setInt(key, value);
    } else {
      return await prefs.setDouble(key, value);
    }
  }

//! this method to get data already saved in local database

  dynamic getData({required String key}) {
    return prefs.get(key);
  }

//! remove data using specific key

  Future<bool> removeData({required String key}) async {
    return await prefs.remove(key);
  }

//! this method to check if local database contains {key}
  Future<bool> containsKey({required String key}) async {
    return prefs.containsKey(key);
  }

  Future<bool> clearData({required String key}) async {
    return prefs.clear();
  }

//! this fun to put data in local data base using key
  Future<dynamic> put({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await prefs.setString(key, value);
    } else if (value is bool) {
      return await prefs.setBool(key, value);
    } else {
      return await prefs.setInt(key, value);
    }
  }
}
