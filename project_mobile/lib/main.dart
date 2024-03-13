//import del materiale standard
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import del controller per la navigazione
import 'package:project_mobile/route/route.dart' as route;

void main() {
  runApp(MyApp());
}

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
}
