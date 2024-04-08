//import per il materiale di "design"
import 'package:flutter/material.dart';

//faccio l'import delle pagine in cui voglio navigare
//import 'package:project_mobile/screens/loginpage.dart';
//import 'package:project_mobile/screens/signup.dart';
import 'package:project_mobile/screens/homepage.dart';
import 'package:project_mobile/screens/settingspage.dart';
import 'package:project_mobile/screens/calendar.dart';
import 'package:project_mobile/screens/listpage.dart';
import 'package:project_mobile/screens/authpage.dart';
import 'package:project_mobile/screens/weekpage.dart';
import 'package:project_mobile/screens/todovideo/todolistpage.dart';

//nomi da dare alle pagine in cui andare attraverso delle stringhe costanti
const String homePage = 'home';
const String settingsPage = 'settings';
const String calendarPage = 'calendar';
const String listPage = 'list';
const String authPage = 'auth';
const String weekPage = 'week';
const String toDoListPage = 'todolist';
//const String signupPage = 'signup';
//const String loginPage = 'login';

//il controller che gestirà il passaggio da una pagina ad un'altra
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case authPage:
      return MaterialPageRoute(builder: (context) => AuthPage());
    case homePage:
      return MaterialPageRoute(builder: (context) => HomePage());
    case listPage:
      return MaterialPageRoute(builder: (context) => ListPage());
    case calendarPage:
      return MaterialPageRoute(builder: (context) => Calendar());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case weekPage:
      return MaterialPageRoute(builder: (context) => WeekPage());
    case toDoListPage:
      return MaterialPageRoute(builder: (context) => ToDoListPage());
  /*case loginPage:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case signupPage:
      return MaterialPageRoute(builder: (context) => SignUpPage());*/

    default:
      throw ('This route name does not exist');
  }
}
