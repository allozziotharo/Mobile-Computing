//import del materiale standard
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import del controller per la navigazione
import 'package:project_mobile/route/route.dart' as route;


import 'package:firebase_core/firebase_core.dart';
import 'package:project_mobile/preferences/todolist_pref.dart';
import 'firebase_options.dart';


//le metto tutte sticazzi cosi non abbiamo problemi
import 'package:project_mobile/screens/homepage.dart';
//import 'package:project_mobile/screens/loginpage.dart';
//import 'package:project_mobile/screens/settingspage.dart';
//import 'package:project_mobile/screens/signup.dart';
//import 'package:project_mobile/screens/calendar.dart';
//import 'package:project_mobile/screens/listpage.dart';
import 'package:project_mobile/screens/authpage.dart';
import 'package:project_mobile/preferences/list_pref.dart';

import 'package:project_mobile/screens/todolistpage/todolistpage.dart';

import 'package:project_mobile/services/auth.dart';
//import 'package:recaptcha_v2_checkbox/recaptcha_v2_checkbox.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await ToDoListPreferences.init();
  await ListPreferences.init();
  runApp(MyApp());
}




class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

@override
Widget build(BuildContext context) {
  return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: route.controller,
      theme: ThemeData(
          textTheme: GoogleFonts.oxaniumTextTheme(Theme.of(context).textTheme)),
      home: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {

          if(snapshot.hasData) {
            ToDoListPage();
            return HomePage();
          }
          else {
            return AuthPage();
          }
        }
      )
    );
  }
}