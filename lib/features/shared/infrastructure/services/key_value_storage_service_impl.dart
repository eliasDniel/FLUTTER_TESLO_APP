import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_storage_service.dart';

class KeyValueStorageServiceImpl implements KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    switch (T) {
      case String:
        return prefs.getString(key) as T?;
      case bool:
        return prefs.getBool(key) as T?;
      case double:
        return prefs.getDouble(key) as T?;
      case int:
        return prefs.getInt(key) as T?;
      case List:
        return prefs.getStringList(key) as T?;
      default:
        throw UnimplementedError('Type $T not implemented');
    }
  }

  @override
  Future<bool> remove(String key) async {
    final prefs = await getSharedPrefs();
    return prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();
    switch (T) {
      case String:
        await prefs.setString(key, value as String);
        break;
      case bool:
        await prefs.setBool(key, value as bool);
        break;
      case double:
        await prefs.setDouble(key, value as double);
        break;
      case int:
        await prefs.setInt(key, value as int);
        break;
      case List:
        await prefs.setStringList(key, value as List<String>);
        break;
      default:
        throw UnimplementedError('Type $T not implemented');
    }
  }
}
