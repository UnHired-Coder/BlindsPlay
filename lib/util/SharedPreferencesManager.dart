import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static final SharedPreferencesManager _instance =
      SharedPreferencesManager._internal();

  SharedPreferences? _preferences;

  // Private constructor
  SharedPreferencesManager._internal();

  // Factory constructor to return the singleton instance
  factory SharedPreferencesManager() {
    return _instance;
  }

  // Initialize SharedPreferences
  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Save a string value
  Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  // Get a string value
  String? getString(String key) {
    return _preferences?.getString(key);
  }

  // Remove a value
  Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }
}
