import 'package:flutter/material.dart';


//creo il widget NavBar menù laterale
class NavBar extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    return Drawer (
      child: ListView(
        //rimuovere il padding rende la sidebar più carina
        padding: EdgeInsets.zero,
        //
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Germano'),
            accountEmail: Text('fragermano@numberone.com'),
            currentAccountPicture: CircleAvatar(
             child: ClipOval(
               child: Image.asset(
                 'assets/prova.jpg',
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),//la parte di clipOval credo si possa togliere e lasciare solo CircleAvatar
              ),
            ),//Circle avatar
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg'
                ),
              ),
            ),
          ),//userheader

          //lista delle sezioni del menù laterale
          //IN EVIDENZA
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('In Evidenza'),
            onTap: () => null,
          ),
          //LINK
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Links'),
            onTap: () => null,
          ),
          //CALENDARIO
          ListTile(
            leading: Icon(Icons.date_range),
            title: Text('Calendario'),
            onTap: () => null,
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
                  child: Text(
                    '1', //ora metto uno per comodità qui bisogna aggiungere la logica per cui si aggiunge una notifica
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          //divider aggiunge una linea di separazione
          Divider(),  
          //IMPOSTAZIONI
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Impostazioni'),
            onTap: () => null,
          ),
          Divider(),
          //LOGOUT
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => null,
          ),
          //fine lista
        ],
      ),
    );
  }
}

//screen che contiene un menu laterale a scomparsa
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  @override
  Widget build (BuildContext context){
    return Scaffold(
      drawer: NavBar(),  //widget creato sopra -> menu laterale
      appBar: AppBar(
        title: Text('HomePage'),  //se metto text come child di center viene un po' sulla dx a causa dell'icona del menu
      ),
      body: Center(),
    );
  }
}