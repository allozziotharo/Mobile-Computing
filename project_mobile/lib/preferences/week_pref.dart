import 'package:project_mobile/widget/DayItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class WeekPreferences {
  static late SharedPreferences _preferences;

  //lista che contiene i giorni della settimana
  static const List<String> _days = [
    "monday",
    "tuesday",
    "wednesday", //da usare come chiavi per accedere ai giorni
    "thursday",
    "friday"
  ];
  /*****************************************/

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static setDay2List(Map<String, List<ClassItem>> map) {
    //per ogni giorno (chiave della mappa) salvo una lista
    for (var key in _days) {
      List<String> temp =
          map[key]!.map((item) => json.encode(item.toMap())).toList();
      _preferences.setStringList(key, temp);
    }
  }

  static Map<String, List<ClassItem>> getDay2List() {
    //mappa da restituire
    Map<String, List<ClassItem>> map = {
      _days[0]: [],
      _days[1]: [],
      _days[2]: [],
      _days[3]: [],
      _days[4]: [],
    };

    //inizializzo la mappa con i valori salvati
    for (var key in _days) {
      List<String>? temp = _preferences.getStringList(key);
      if (temp != null)
        map[key] =
            temp.map((item) => ClassItem.fromMap(jsonDecode(item))).toList();
    }

    return map;
  }
}
