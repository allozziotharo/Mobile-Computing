//import per il materiale di "design"
import 'package:flutter/material.dart';

//faccio l'import delle pagine in cui voglio navigare
import 'package:project_mobile/screens/homepage.dart';
import 'package:project_mobile/screens/loginpage.dart';
import 'package:project_mobile/screens/settingspage.dart';
import 'package:project_mobile/screens/signup.dart';

//nomi da dare alle pagine in cui andare attraverso delle stringhe costanti
const String loginPage = 'login';
const String homePage = 'home';
const String settingsPage = 'settings';
const String signupPage = 'signup';

//il controller che gestirà il passaggio da una pagina ad un'altra
Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case loginPage:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case homePage:
      return MaterialPageRoute(builder: (context) => HomePage());
    case settingsPage:
      return MaterialPageRoute(builder: (context) => SettingsPage());
    case signupPage:
      return MaterialPageRoute(builder: (context) => SignUpPage());
    default:
      throw ('This route name does not exist');
  }
}
