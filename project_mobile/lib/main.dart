//import del materiale standard
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import del controller per la navigazione
import 'package:project_mobile/route/route.dart' as route;


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

//le metto tutte sticazzi cosi non abbiamo problemi
import 'package:project_mobile/screens/homepage.dart';
import 'package:project_mobile/screens/loginpage.dart';
import 'package:project_mobile/screens/settingspage.dart';
import 'package:project_mobile/screens/signup.dart';
import 'package:project_mobile/screens/calendar.dart';
import 'package:project_mobile/screens/listpage.dart';
import 'package:project_mobile/screens/authpage.dart';

import 'package:project_mobile/services/auth.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}


/*
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.oxaniumTextTheme(Theme.of(context).textTheme)),
      onGenerateRoute: route.controller, //crea il controller nel file route
      initialRoute:
          route.listPage, //la prima pagina visualizzaa è quella di login
    );
  }
}*/  //instradamento andrea


class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: GoogleFonts.oxaniumTextTheme(Theme.of(context).textTheme)),
            onGenerateRoute: route.controller,
            initialRoute: route.homePage,
          );
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                textTheme: GoogleFonts.oxaniumTextTheme(Theme.of(context).textTheme)),
            onGenerateRoute: route.controller,
            initialRoute: route.authPage,
          );
        }
      },
    );
  }
}