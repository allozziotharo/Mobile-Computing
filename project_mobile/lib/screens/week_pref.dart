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
    "thursday", //forse non servono
    "friday"
  ];
  /*****************************************/

  //static const _keyMap2List = 'mymap';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static setDay2List(Map<String, List<ClassItem>> map) {
    //per ogni giorno (chiave della mappa) salvo una lista

    List<String> mnList =
        map['monday']!.map((item) => json.encode(item.toMap())).toList();
    _preferences.setStringList('monday', mnList);
    List<String> teList =
        map['tuesday']!.map((item) => json.encode(item.toMap())).toList();
    _preferences.setStringList('tuesday', teList);
    List<String> wdList =
        map['wednesday']!.map((item) => json.encode(item.toMap())).toList();
    _preferences.setStringList('wednesday', wdList);
    List<String> thList =
        map['thursday']!.map((item) => json.encode(item.toMap())).toList();
    _preferences.setStringList('thursday', thList);
    List<String> frList =
        map['friday']!.map((item) => json.encode(item.toMap())).toList();
    _preferences.setStringList('friday', frList);
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

    //inizializzare
    List<String>? mnList = _preferences.getStringList('monday');
    if (mnList != null)
      map['monday'] =
          mnList.map((item) => ClassItem.fromMap(jsonDecode(item))).toList();

    List<String>? teList = _preferences.getStringList('tuesday');
    if (teList != null)
      map['tuesday'] =
          teList.map((item) => ClassItem.fromMap(jsonDecode(item))).toList();

    List<String>? wdList = _preferences.getStringList('wednesday');
    if (wdList != null)
      map['wednesday'] =
          wdList.map((item) => ClassItem.fromMap(jsonDecode(item))).toList();

    List<String>? thList = _preferences.getStringList('thursday');
    if (thList != null)
      map['thursday'] =
          thList.map((item) => ClassItem.fromMap(jsonDecode(item))).toList();

    List<String>? frList = _preferences.getStringList('friday');
    if (frList != null)
      map['friday'] =
          frList.map((item) => ClassItem.fromMap(jsonDecode(item))).toList();

    return map;
  }
}
