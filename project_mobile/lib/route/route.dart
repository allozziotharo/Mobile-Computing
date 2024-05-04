//import per il materiale di "design"
import 'package:flutter/material.dart';

//faccio l'import delle pagine in cui voglio navigare

import 'package:project_mobile/screens/homepage.dart';
import 'package:project_mobile/screens/authpage.dart';
import 'package:project_mobile/screens/settingspage.dart';
import 'package:project_mobile/screens/signup.dart';
import 'package:project_mobile/screens/calendarpage.dart';
import 'package:project_mobile/screens/exampage.dart';
import 'package:project_mobile/preferences/week_pref.dart';
import 'package:project_mobile/screens/weekpage.dart';
import 'package:project_mobile/screens/todolistpage/todolistpage.dart';
import 'package:project_mobile/screens/statistiche.dart';

//nomi da dare alle pagine in cui andare attraverso delle stringhe costanti
const String authPage = 'auth';
const String homePage = 'home';
const String settingsPage = 'settings';
const String signupPage = 'signup';
const String calendarPage = 'calendar';
const String examPage = 'exam';
const String weekPage = 'weekpage';
const String toDoListPage = 'todolist';
const String statistiche = 'statistiche';

//il controller che gestirà il passaggio da una pagina ad un'altra
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case authPage:
      return MaterialPageRoute(builder: (context) => AuthPage());
    case homePage:
      return MaterialPageRoute(builder: (context) => HomePage());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case signupPage:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case calendarPage:
      return MaterialPageRoute(builder: (context) => CalendarPage());
    case examPage:
      return MaterialPageRoute(builder: (context) => ExamPage());
    case toDoListPage:
      return MaterialPageRoute(builder: (context) => ToDoListPage());
    case statistiche:
      return MaterialPageRoute(builder: (context) => Statistiche());
    case weekPage:
      WeekPreferences.init(); // si può fare
      return MaterialPageRoute(builder: (context) => WeekPage());
    default:
      throw ('This route name does not exist');
  }
}
