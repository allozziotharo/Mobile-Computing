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
        backgroundColor: Colors.blue[800],
        shadowColor: Colors.blue[800],
   //     surfaceTintColor: Colors.blue[800],
        title: const Text(
              'HomePage',
              style: TextStyle(
                color: Colors.white,
              )
            ),
        actions: [
          IconButton(onPressed: (){
            signOut();
          },
          icon: Icon(Icons.logout,
            color: Colors.white,
            )
          )
        ]
      ),
      body: ListView(
        padding: EdgeInsets.all(5),
        children: [

          //DIVISORE
          Divider(),

          //TO-DO LIST
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/fotoToDoList.jpg'),
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.srcOver
                ),
              ),
            ),            
            child:
            ListTile(
              
              leading:
                Icon(
                  Icons.checklist_rounded,
                  size: 50,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 50.0,
                      color: Colors.black.withOpacity(1),
                      offset: Offset(0,0),
                    ),
                  ],
                ),
              title: Text("To-Do List",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 50.0,
                    color: Colors.black.withOpacity(1),
                    offset: Offset(3,3),
                    ),
                ],
                ),
              ),
              onTap: (){
                Navigator.pushNamed(context, route.toDoListPage);
              }
            ),
          ),
          //DIVISORE
          Divider(),          

          //SETTIMANA CORRENTE
          Container(
            height: 150,           
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/fotoWeekPage(2).jpg'),
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.srcOver
                ),
              ),
            ),
            child: 
            ListTile(
              leading: Icon(Icons.table_rows_rounded,
                  size: 50,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 50.0,
                      color: Colors.black.withOpacity(1),
                      offset: Offset(0,0),
                    ),
                  ],
                ),
              title: Text("Timetable",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                  Shadow(
                    blurRadius: 50.0,
                    color: Colors.black.withOpacity(1),
                    offset: Offset(3,3),
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.pushNamed(context, route.weekPage);
              }  
            ),
          ),
          //DIVISORE
          Divider(),

          //LIBRETTO
          Container(
            height: 150, 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/fotoLibretto.jpg'),
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.srcOver
                ),
              ),
            ),
            child: ListTile(
              leading: Icon(
                Icons.menu_book_rounded,
                  size: 50,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 50.0,
                      color: Colors.black.withOpacity(1),
                      offset: Offset(0,0),
                    ),
                  ],
                ),
              title: Text("Grades' Book",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                  Shadow(
                    blurRadius: 50.0,
                    color: Colors.black.withOpacity(1),
                    offset: Offset(3,3),
                    ),
                  ],
                ),
              ),
              onTap: () => Navigator.pushNamed(context, route.listPage),
            ),
          ),
                    
          //DIVISORE
          Divider(),

          
          //STATISTICHE
          Container(
            height: 150, 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/fotoStatsPage.jpg'),
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.srcOver,
                ),
              ),
            ),
            child:
            ListTile(
              leading: Icon(Icons.bar_chart_rounded,
                  size: 50,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 50.0,
                      color: Colors.black.withOpacity(1),
                      offset: Offset(0,0),
                    ),
                  ],
                ),
              title: Text("Stats",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [
                  Shadow(
                    blurRadius: 50.0,
                    color: Colors.black.withOpacity(1),
                    offset: Offset(3,3),
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.pushNamed(context, route.calendarPage);
              }
            ),
          ),
          

        ]
      ),
    );
  }
}