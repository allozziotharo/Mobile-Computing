import 'package:flutter/material.dart';
import 'constants/costantiGUI.dart';
import 'constants/Fonts.dart';
import 'screens/HomeScreen.dart';
//import 'package:project_mobile/hierarchy/Section.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(), //poi andrà impostato lo splashscreen come schermata iniziale, ora si comincia con la home
    );
  }
}
