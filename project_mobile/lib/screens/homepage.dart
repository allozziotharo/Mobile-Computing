//materiale standard
import 'package:flutter/material.dart';
import 'package:project_mobile/preferences/home_pref.dart';
import 'package:project_mobile/widget/NavBar.dart';
//import per usare route  -> sta su navBar non serve qui
//import 'package:project_mobile/route/route.dart' as route;

//screen che contiene un menu laterale a scomparsa
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int counter = 0;

  @override
  void initState() {
    super.initState();
    counter = HomePreferences.getCounter();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(), //widget creato sopra -> menu laterale
      appBar: AppBar(
        title: const Text(
            'HomePage'), //se metto text come child di center viene un po' sulla dx a causa dell'icona del menu
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${counter}',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      counter++;
                      HomePreferences.setCounter(counter);
                    });
                  },
                  icon: Icon(Icons.add)),
            ),
          ],
        ),
      ),
    );
  }
}
