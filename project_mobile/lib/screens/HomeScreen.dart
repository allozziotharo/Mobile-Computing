import 'package:flutter/material.dart';
import 'package:project_mobile/constants/costantiGUI.dart';
import 'package:project_mobile/constants/Fonts.dart';
import 'package:project_mobile/hierarchy/Section.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> { //è la classe che gestisce la schermata home
  List<Section> sections = []; //lista di sezioni presente nella home

  @override
  Widget build(BuildContext context) {
    return Scaffold(  //layout con appbar e body che ci serve per fare una home
      appBar: AppBar(
        title: Text(
          'Select a sphere of your life you want to manage, or create a new one',
          overflow: TextOverflow.ellipsis, 
          maxLines: 3,
          textAlign: TextAlign.center,
          style: TextStyle(fontStyle: FontStyle.italic),
          ),
        centerTitle: true,        
        backgroundColor: Color(costantiGUI.primaryColor),
      ),
      body: ListView(  //nel body ci vanno le sezioni
        children: <Widget>[
          for (int i = 0; i < sections.length; i++)
            SectionWidget(
              section: sections[i],
              onTap: () {
                // Implementa la logica per toccare una sezione esistente, DA FARE
              },
              onLongPress: () {
                section._showSectionContextMenu(sections[i]);
              },
            ),
          AddSectionButton(
            onTap: () {
              section._showAddSectionDialog(context);
            },
          ),
        ],
      ),
    );
  }

}

class AddSectionButton extends StatelessWidget {//crea il bottone per aggiungere sezioni DELLA HOME
  final VoidCallback onTap;

  AddSectionButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40.0,
        height: 40.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Color(costantiGUI.secondaryColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          '+',
          style: TextStyle(fontSize: 24.0, color: Colors.white),
        ),
      ),
    );
  }
}
