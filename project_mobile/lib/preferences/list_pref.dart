import 'package:project_mobile/widget/ListItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ListPreferences {
  static late SharedPreferences _preferences;

  static const String key = 'exams';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static setListItem(List<ListItem> list) {
    List<String> temp = list.map((item) => json.encode(item.toMap())).toList();
    _preferences.setStringList(key, temp);
  }

  static List<ListItem> getListItem() {
    List<ListItem> list = [];
    List<String>? temp = _preferences.getStringList(key);
    if (temp != null)
      temp.map((item) => ListItem.fromMap(jsonDecode(item))).toList();
    return list;
  }
}
