import 'package:shared_preferences/shared_preferences.dart';

class HomePreferences {
  static late SharedPreferences _preferences;

  static const String key = 'counter';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static setCounter(int counter) {
    _preferences.setInt(key, counter);
  }

  static int getCounter() {
    int val = 0;
    if (_preferences.getInt(key) != null) val = _preferences.getInt(key)!;
    return val;
  }
}
