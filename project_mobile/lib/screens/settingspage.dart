//materiale standard
import 'package:flutter/material.dart';
//import per usare route
import 'package:project_mobile/route/route.dart' as route;


class SettingsPage extends StatelessWidget{
    const SettingsPage ({super.key});

    @override
    Widget build(BuildContext context){
        return Scaffold(
            appBar: AppBar(
                title: Text('Settings'),
            ),
            body: ElevatedButton(
                child: Text('back home', style: TextStyle(color: Colors.white),),
                onPressed: () => Navigator.pushNamed(context, route.homePage),
            ),
        ); //fine di scaffold quello che ritorna build -> quindi alla fine ; (credo)
    }
}