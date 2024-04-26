import 'package:project_mobile/widget/ExamItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ExamPreferences {
  static late SharedPreferences _preferences;

  static const String key = 'exams';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  //salva una lista di ExamItem in locale
  //ExamItem {string esame, int voto, String data}
  static setListItem(List<ExamItem> list) {
    List<String> temp = list.map((item) => json.encode(item.toMap())).toList();
    _preferences.setStringList(key, temp);
  }

  //restituisce la lista salvata oppure [] se non trova nulla
  static List<ExamItem> getListItem() {
    List<ExamItem> list = [];
    List<String>? temp = _preferences.getStringList(key);
    if (temp != null)
      list = temp.map((item) => ExamItem.fromMap(jsonDecode(item))).toList();
    return list;
  }
}
