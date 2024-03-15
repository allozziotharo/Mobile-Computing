//import del materiale standard
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



//import del controller per la navigazione
import 'package:project_mobile/route/route.dart' as route;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
