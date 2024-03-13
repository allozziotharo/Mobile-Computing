//materiale standard
import 'package:flutter/material.dart';
import 'package:project_mobile/widget/NavBar.dart';
//import per usare route
import 'package:project_mobile/route/route.dart' as route;

//screen che contiene un menu laterale a scomparsa
class HomePage extends StatefulWidget {
  //costruttore privato
  HomePage._();
  //istanza unica
  static HomePage _instance = HomePage._();
  //metodo factory
  factory HomePage() {
    return _instance;
  }

  int counter = 0;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              '${widget.counter}',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.black,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.counter++;
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
