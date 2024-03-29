//materiale standard
import 'package:flutter/material.dart';
import 'package:project_mobile/widget/NavBar.dart';

//import per usare route
import 'package:project_mobile/route/route.dart' as route;

//import per autenticazione, SERVE A RICHIAMARE 'Auth()'
import 'package:project_mobile/services/auth.dart';

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

/*
class _HomePageState extends State<HomePage> {

  Future<void> signOut() async{
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(), //widget creato sopra -> menu laterale
      appBar: AppBar(
        title: const Text(
            'HomePage'), //se metto text come child di center viene un po' sulla dx a causa dell'icona del menu
        actions: [
          IconButton(onPressed: (){
            signOut();
          }, icon: Icon(Icons.logout))
        ]
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
*/ // METODO COUNTER DE PRIMA


class _HomePageState extends State<HomePage> {

  Future<void> signOut() async{
    await Auth().signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(), //widget creato sopra -> menu laterale
      appBar: AppBar(
        title: const Text(
            'HomePage'), //se metto text come child di center viene un po' sulla dx a causa dell'icona del menu
        actions: [
          IconButton(onPressed: (){
            signOut();
          }, icon: Icon(Icons.logout))
        ]
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [

          //DIVISORE
          Divider(),

          //TO-DO LIST
          
          ListTile(
            leading: Icon(Icons.checklist_rounded),
            title: const Text("TO-DO LIST"),
            onTap: (){
              Navigator.pushNamed(context, route.toDoListPage);
            } //TODO: implementare cambio pagina
          ),
          

          //SETTIMANA CORRENTE
          ListTile(
            leading: Icon(Icons.table_rows_rounded),
            title: const Text("Settimana Corrente"),
            onTap: (){
              Navigator.pushNamed(context, route.weekPage);
            }  
          ),

          //LIBRETTO
          ListTile(
            leading: Icon(Icons.menu_book_rounded),
            title: const Text('Libretto'),
            onTap: () => Navigator.pushNamed(context, route.listPage),
          ),
          

          /*
          //STATISTICHE
          ListTile(
            leading: Icon(Icons.bar_chart_rounded),
            title: const Text("Statistiche"),
            onTap: (){
              Navigator.pushNamed(context, route.weekPage);
            }
          ),
          */

        ]
      ),
    );
  }
}