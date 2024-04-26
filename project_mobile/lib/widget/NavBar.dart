//materiale standard
import 'package:flutter/material.dart';
//import per usare route
import 'package:project_mobile/route/route.dart' as route;

//creo il widget NavBar menù laterale
class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        //rimuovere il padding rende la sidebar più carina
        padding: EdgeInsets.zero,
        //tutti gli elementi che compongono la sidebar
        children: [
          //prima parte del menu quella che contieni gli info dell'user
          UserAccountsDrawerHeader(
            accountName:
                const Text('Germano', style: TextStyle(color: Colors.white)),
            accountEmail: const Text('fragermano@numberone.com',
                style: TextStyle(color: Colors.white)),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  //immagine salvata sul dispositivo si usa in questo modo
                  'assets/prova.jpg', //devi prima aggiungere la risorsa nella cartella assets
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ), //la parte di clipOval credo si possa togliere e lasciare solo CircleAvatar
              ),
            ), //Circle avatar
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/userbackground.jpg"),
              ),
            ),
          ), //userheader

          //lista delle sezioni del menù laterale
          //IN EVIDENZA
          ListTile(
            leading: Icon(Icons.favorite),
            title: const Text('In Evidenza'),
            onTap: () => null,
          ),
          //LINK
          ListTile(
            leading: Icon(Icons.share),
            title: const Text('Links'),
            onTap: () => null,
          ),
          //CALENDARIO
          ListTile(
            leading: Icon(Icons.date_range),
            title: const Text('Calendario'),
            onTap: () => Navigator.pushNamed(context, route.calendarPage),
          ),
          //NOTIFICHE
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifiche'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: Center(
                  child: const Text(
                      '1', //ora metto uno per comodità qui bisogna aggiungere la logica per cui si aggiunge una notifica
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                ),
              ),
            ),
          ),
          //divider aggiunge una linea di separazione
          Divider(),
          //IMPOSTAZIONI
          ListTile(
            leading: Icon(Icons.settings),
            title: const Text('Impostazioni'),
            onTap: () => Navigator.pushNamed(context, route.examPage),
          ),
          Divider(),
          //LOGOUT
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            onTap: () => Navigator.pushNamed(context, route.loginPage),
          ),
          ListTile(
            leading: Icon(Icons.wheelchair_pickup_outlined),
            title: const Text('classes page'),
            onTap: () => Navigator.pushNamed(context, route.weekPage),
          ),
          ListTile(
            leading: Icon(Icons.architecture_outlined),
            title: const Text('stats pagw'),
            onTap: () => Navigator.pushNamed(context, route.statsPage),
          )
          //fine lista
        ],
      ),
    ); //qui finisce drawer e si fa il return -> ;
  } //qui finisce widget build
} //qui finisce la classe NavBar