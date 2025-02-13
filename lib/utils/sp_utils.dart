import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// This class contains methods to save and retrieve data from SharedPreferences
class SpUtils {
  SpUtils._internal();
  static final SpUtils _spUtils = SpUtils._internal();

  static SharedPreferences? _sp;
  factory SpUtils() {
    return _spUtils;
  }

  /// Initialize the shared preferences instance
  static Future<SharedPreferences?> init() async {
    _sp = await SharedPreferences.getInstance();
    return _sp;
  }

  static bool isInit() {
    return _sp != null;
  }

  /// Put a value with the given [key] into shared preferences
  static Future<bool>? put(String key, Object value) {
    if (value is int) {
      return putInt(key, value);
    } else if (value is String) {
      return putString(key, value);
    } else if (value is bool) {
      return putBool(key, value);
    } else if (value is double) {
      return putDouble(key, value);
    } else if (value is List<String>) {
      return putStringList(key, value);
    }
    throw Exception("wrong value");
  }

  /// Put an object with the given [key] into shared preferences
  static Future<bool>? putObject(String key, Object value) {
    if (_sp == null) return null;
    return _sp!.setString("object_$key", json.encode(value));
  }

  /// Get an object with the given [key] from shared preferences
  static T getObj<T>(String key, T Function(Map v) f, {required T defValue}) {
    Map? map = getObject(key);
    return f(map);
  }

  /// Get an object with the given [key] from shared preferences
  static Map<String, dynamic> getObject(String key) {
    if (_sp == null) return {};
    String? data = _sp!.getString("object_$key");
    return (data == null || data.isEmpty) ? {} : json.decode(data);
  }

  /// Put a list of objects with the given [key] into shared preferences
  static Future<bool>? putObjectList(String key, List<Object> list) {
    if (_sp == null) return null;
    List<String>? dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return _sp!.setStringList(key, dataList);
  }

  /// Get a list of objects with the given [key] from shared preferences
  static List<T> getObjList<T>(String key, T Function(Map<String, dynamic> v) f,
      {List<T>? defValue}) {
    List<Map<String, dynamic>>? dataList = _getObjectList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    }).toList();
    return list ?? (defValue ?? []);
  }

  /// Get a list of objects with the given [key] from shared preferences
  static List<Map<String, dynamic>>? _getObjectList(String key) {
    if (_sp == null) return null;
    List<String>? dataLis = _sp!.getStringList(key);
    return dataLis?.map((value) {
      var dataMap = json.decode(value);
      if (dataMap is Map<String, dynamic>) {
        return dataMap;
      }
      dataMap = json.decode(json.decode(value)) as Map<String, dynamic>;
      return dataMap;
    }).toList();
  }

  /// Get a string with the given [key] from shared preferences
  static String getString(String key, {String defValue = ''}) {
    if (_sp == null) return defValue;
    return _sp!.getString(key) ?? defValue;
  }

  /// Put a string with the given [key] into shared preferences
  static Future<bool>? putString(String key, String value) {
    if (_sp == null) return null;
    return _sp!.setString(key, value);
  }

  /// Get a boolean with the given [key] from shared preferences
  static bool getBool(String key, {bool defValue = false}) {
    if (_sp == null) return defValue;
    return _sp!.getBool(key) ?? defValue;
  }

  /// Put a boolean with the given [key] into shared preferences
  static Future<bool>? putBool(String key, bool value) {
    if (_sp == null) return null;
    return _sp!.setBool(key, value);
  }

  /// Get an integer with the given [key] from shared preferences
  static int getInt(String key, {int defValue = 0}) {
    if (_sp == null) return defValue;
    return _sp!.getInt(key) ?? defValue;
  }

  /// Put an integer with the given [key] into shared preferences
  static Future<bool>? putInt(String key, int value) {
    if (_sp == null) return null;
    return _sp!.setInt(key, value);
  }

  /// Get a double with the given [key] from shared preferences
  static double getDouble(String key, {double defValue = 0.0}) {
    if (_sp == null) return defValue;
    return _sp!.getDouble(key) ?? defValue;
  }

  /// Put a double with the given [key] into shared preferences
  static Future<bool>? putDouble(String key, double value) {
    if (_sp == null) return null;
    return _sp!.setDouble(key, value);
  }

  /// Get a list of strings with the given [key] from shared preferences
  static List<String> getStringList(String key,
      {List<String> defValue = const []}) {
    if (_sp == null) return defValue;
    return _sp!.getStringList(key) ?? defValue;
  }

  /// Put a list of strings with the given [key] into shared preferences
  static Future<bool>? putStringList(String key, List<String> value) {
    if (_sp == null) return null;
    return _sp!.setStringList(key, value);
  }

  /// Get a dynamic value with the given [key] from shared preferences
  static dynamic getDynamic(String key, {Object? defValue}) {
    if (_sp == null) return defValue;
    return _sp!.get(key) ?? defValue;
  }

  /// Check if shared preferences contains the given [key]
  static bool? haveKey(String key) {
    if (_sp == null) return null;
    return _sp!.getKeys().contains(key);
  }

  /// Get a set of all keys in shared preferences
  static Set<String>? getKeys() {
    if (_sp == null) return null;
    return _sp!.getKeys();
  }

  /// Remove the value with the given [key] from shared preferences
  static Future<bool>? remove(String key) {
    if (_sp == null) return null;
    return _sp!.remove(key);
  }

  /// Clear all values from shared preferences
  static Future<bool>? clear() {
    if (_sp == null) return null;
    return _sp!.clear();
  }
}
