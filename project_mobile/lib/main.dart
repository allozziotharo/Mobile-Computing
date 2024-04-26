//import del materiale standard
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_mobile/preferences/home_pref.dart';
import 'package:project_mobile/preferences/exam_pref.dart';

//import del controller per la navigazione
import 'package:project_mobile/route/route.dart' as route;
import 'package:project_mobile/screens/homepage.dart';
import 'package:project_mobile/screens/statistiche.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HomePreferences.init();
  await ExamPreferences.init();
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
      //initialRoute:
      //route.homePage, //la prima pagina visualizzata è quella di login
      home: Statistiche(),
    );
  }
}

/*home page per provare il grafico
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
          child: Container(
        color: Colors.blueGrey[900],
        height: 400,
        width: 400,
        child: MyBarChart(),
      )),
    );
  }
}
*/


/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_mobile/prova_sharedp/user_page.dart';
import 'package:project_mobile/prova_sharedp/user_simple_preferences.dart';
import 'package:project_mobile/screens/weekpage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await UserSimplePreferences.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final String title = 'Shared Preferences';

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff8c52ff),
          unselectedWidgetColor: Colors.deepPurple.shade200,
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(Colors.white),
          ),
          colorScheme: ColorScheme.dark()
              .copyWith(secondary: Colors.lightGreen.shade400),
        ),
        home: UserPage(),
      );
}
*/
