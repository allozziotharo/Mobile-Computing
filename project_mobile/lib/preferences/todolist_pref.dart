
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project_mobile/screens/todolistpage/task.dart';

import 'dart:convert';

class ToDoListPreferences {
  static late SharedPreferences _preferences;

  static const String key = 'list';

  static Future init() async => _preferences = await SharedPreferences.getInstance();

  
  static setToDoList(List<Task> list) {
    List<String> tdList = list.map((item) => json.encode(item.toMap())).toList();
    _preferences.setStringList(key, tdList);
  }

  static List<Task> getToDoList() {
    List<Task> list = [];
    List<String>? listString = _preferences.getStringList(key);
    if(listString != null) list = listString.map((item) => Task.fromMap(json.decode(item))).toList();
    return list;
  }

  





}
