//import del materiale standard
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

//import del controller per la navigazione
import 'package:project_mobile/route/route.dart' as route;

void main() {
  runApp(MyApp());
}

//ROUTING VERO
/* 
class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: HomeScreen(), //poi andrà impostato lo splashscreen come schermata iniziale, ora si comincia con la home

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme:
              GoogleFonts.lobsterTwoTextTheme(Theme.of(context).textTheme)),
      onGenerateRoute: route.controller, //crea il controller nel file route
      initialRoute:
          route.signupPage, //la prima pagina visualizzata è quella di login

    );
  }
}
*/


//ROUTING X PROVE SCREEN

class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme:
              GoogleFonts.lobsterTwoTextTheme(Theme.of(context).textTheme)),
      onGenerateRoute: route.controller, //crea il controller nel file route
      initialRoute:
          route.screenPage, //la prima pagina visualizzata è quella di PROVA

    );
  }
}
