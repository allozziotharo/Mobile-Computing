//import per il materiale di "design"
import 'package:flutter/material.dart';

//faccio l'import delle pagine in cui voglio navigare
import 'package:project_mobile/screens/homepage.dart';
import 'package:project_mobile/screens/loginpage.dart';
import 'package:project_mobile/screens/statistiche.dart';
import 'package:project_mobile/screens/settingspage.dart';
import 'package:project_mobile/screens/signup.dart';
import 'package:project_mobile/screens/calendarpage.dart';
import 'package:project_mobile/screens/exampage.dart';
import 'package:project_mobile/preferences/week_pref.dart';
import 'package:project_mobile/screens/weekpage.dart';

//nomi da dare alle pagine in cui andare attraverso delle stringhe costanti
const String loginPage = 'login';
const String homePage = 'home';
const String settingsPage = 'settings';
const String signupPage = 'signup';
const String calendarPage = 'calendar';
const String examPage = 'exam';
const String weekPage = 'weekpage';
const String statsPage = 'stats';

//il controller che gestirà il passaggio da una pagina ad un'altra
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginPage:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case homePage:
      return MaterialPageRoute(builder: (context) => HomePage());
    case statsPage:
      return MaterialPageRoute(builder: (context) => Statistiche());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case signupPage:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    case calendarPage:
      return MaterialPageRoute(builder: (context) => CalendarPage());
    case examPage:
      return MaterialPageRoute(builder: (context) => ExamPage());
    case weekPage:
      WeekPreferences.init(); // si può fare
      return MaterialPageRoute(builder: (context) => WeekPage());
    default:
      throw ('This route name does not exist');
  }
}
