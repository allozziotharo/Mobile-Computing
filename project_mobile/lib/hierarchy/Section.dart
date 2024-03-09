import 'package:project_mobile/hierarchy/toolpool/Tool.dart';

class Section {

  late String sectionTitle;
  late DateTime dataCreazione;
  late List<Tool> toolList;
 
  //modelliamo le sezioni come un albero arbitrario,
  //annidamento di figli/aggiunta di fratelli
  late List<Section> childSections;
  Section? parentSection; //nullable per evitare errori nella sezione radice (quelle di profondità 0)
  

  //COSTRUTTORE (PADRE+TITOLO)
  Section(Section? parentSection, String newSectionTitle) {
    this.parentSection = parentSection;
    this.sectionTitle = newSectionTitle;
    //creazione di una lista CHE PUO' CAMBIARE DIMENSIONE
    this.toolList = new List.empty(growable: true);
    this.childSections = new List.empty(growable: true);

    //ORA SEMPRE INIZIALIZZATA
    this.dataCreazione = DateTime.now();
  }


  //getters & setters
  String getSectionTitle() => sectionTitle;
  void setSectionTitle(String newSectionTitle) {this.sectionTitle = newSectionTitle;}

  DateTime getData() => dataCreazione;

  List<Tool> getToolList() => toolList;
  List<Section> getChildSections() => childSections;

  Section? getParentSection() => parentSection;


  void addSection(String newSectionTitle) {
    Section newSection = new Section(this.parentSection, newSectionTitle);
    this.childSections.add(newSection);

  }

  



}