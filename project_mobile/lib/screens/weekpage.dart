import 'package:flutter/material.dart';
import 'package:project_mobile/preferences/week_pref.dart';
import 'package:project_mobile/widget/DayItem.dart';
import 'package:project_mobile/widget/NavBar.dart';
import 'package:project_mobile/widget/flashMessages/confirmMessage.dart';
import 'package:project_mobile/widget/flashMessages/warningMessage.dart';
import 'package:project_mobile/widget/flashMessages/errorMessage.dart';

class WeekPage extends StatefulWidget {
  @override
  _WeekPageState createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  //controller per mostrare nei textfield le ore che sono state scelte
  TextEditingController _timeControllerStart = TextEditingController();
  TextEditingController _timeControllerEnd = TextEditingController();
  /******************************************************/
  //stringa che stampa il giorno corrente
  String _daySelected = "";
  /*************************************/
  //lista che contiene i giorni della settimana
  static const List<String> _days = [
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday"
  ];
  /*****************************************/
  //serve per identificare le animatedList di ogni giorno
  late Map<String, GlobalKey<AnimatedListState>> _dayKey = {
    _days[0]: GlobalKey<AnimatedListState>(),
    _days[1]: GlobalKey<AnimatedListState>(),
    _days[2]: GlobalKey<AnimatedListState>(),
    _days[3]: GlobalKey<AnimatedListState>(),
    _days[4]: GlobalKey<AnimatedListState>(),
  };
  /****************************************************/
  //mappa <giorno, lista_del_giorno>
  late Map<String, List<ClassItem>> dayToList = {
    _days[0]: [],
    _days[1]: [],
    _days[2]: [],
    _days[3]: [],
    _days[4]: [],
  };
  /***********************************/
  //dati lezione
  String notes = ""; //di classItem
  String subject = "";
  TimeOfDay start = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay end = TimeOfDay(hour: 0, minute: 0);
  /**************************************/

  @override
  void initState() {
    super.initState(); //inizializzare le variabili di istanza
    //... dayToList = WeekPref.getMap;
    dayToList = WeekPreferences.getDay2List();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(), //menù laterale
      appBar: AppBar(
          title: Row(
        //non funziona il tooltip
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("YOUR WEEK"),
          IconButton(
              //si può fare meglio
              onPressed: () {
                showWarningMessage(
                    "use this page to set your classes", context);
              },
              icon: Icon(Icons.lightbulb_outline)),
        ],
      )),
      backgroundColor: Colors.blue[800],
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                          //creato una lista con le stringhe dei giorni della settimana
                          5, //anzizhè ripetere il codice 5 volte uso List.generate(...) e lo scrivo una volta sola
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _daySelected = _days[index];
                              });
                            },
                            child: DayItemWidget(day: _days[index]),
                          ),
                        ))),
                    const SizedBox(height: 20),
                    if (_daySelected.isNotEmpty)
                      Text("DAY SELECTED: " + _daySelected,
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    if (_daySelected.isEmpty)
                      const Text(
                        "CHOOSE A DAY!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                  ])),
          if (_daySelected.isNotEmpty) // Check if a day is selected
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              padding: EdgeInsets.only(top: 20),
              child: AnimatedList(
                key: _dayKey[_daySelected],
                initialItemCount:
                    dayToList[_daySelected]?.length ?? 0, // Handle null
                itemBuilder: (context, index, animation) => ClassItemWidget(
                  item: dayToList[_daySelected]![index],
                  animation: animation,
                  onClicked: () => removeItem(index),
                ),
              ),
            ))
        ],
      ),
      //BOTTOM NAVIGATION
      bottomNavigationBar: BottomNavigationBar(items: [
        //il primo elemento è in blu sto nero
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
        BottomNavigationBarItem(icon: Icon(Icons.save_rounded), label: 'save'),
        BottomNavigationBarItem(
            //non compare l'icona poraccio io
            icon: IconButton(
                onPressed: () {
                  if (_daySelected == "") {
                    showWarningMessage(
                        "you must select a day first! BITCHASSNIGGHI", context);
                  } else {
                    readData();
                  }
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                )),
            label: 'add el to list'),
      ]),
    );
  }
  /**************** FINE BUILD ****************/

  void readData() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('insert subject data'),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              buildTextField('subject'),
              buildTextField('notes'),
              buildTimeField('START', _timeControllerStart),
              buildTimeField('END', _timeControllerEnd),
            ]),
            actions: [
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  cleanController();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                  child: const Text('PROCEED'),
                  onPressed: () {
                    if (isTimeIncorrect(end, start)) {
                      showErrorMessage(
                          "ending time must be after the starting one",
                          context);
                      //non resetto i parametri così modifico da dove ero rimasto
                      Navigator.of(context).pop();
                    } else {
                      insertItem(subject, notes, start, end);
                      showConfirmMessage("class succesfully added!", context);
                      cleanController();
                      Navigator.of(context).pop();
                    }
                  }),
            ],
          );
        });
  }

  /*FUNZIONI CHE RESTITUISCONO I MESSAGGI*/
  void showWarningMessage(String warningText, BuildContext context) {
    //messaggio di warning
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: WarningMessageContent(warningText: warningText),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  void showErrorMessage(String errorText, BuildContext context) {
    //messaggio di errore
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: ErrorMessageContent(errorText: errorText),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  void showConfirmMessage(String confirmText, BuildContext context) {
    //messaggio di conferma
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: ConfirmMessageContent(confirmText: confirmText),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }
  /*************************************************/

  void cleanController() {
    this._timeControllerStart.text = '';
    this._timeControllerEnd.text = '';
  }

  bool isTimeIncorrect(TimeOfDay end, TimeOfDay start) {
    return end.hour < start.hour ||
        (end.hour == start.hour && end.minute <= start.minute);
  }

// restituisce il textfield
  Widget buildTextField(String hintText) {
    return TextField(
      onChanged: (value) {
        if (hintText == 'subject') {
          this.subject = value;
        } else {
          this.notes = value;
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }

// restituisce il textfield per gli orari
  Widget buildTimeField(String hintText, TextEditingController controller) {
    return TextField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            prefixIcon: const Icon(Icons.access_time),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
        readOnly: true,
        onTap: () async {
          final TimeOfDay? picked = await showTimePicker(
              context: context, initialTime: TimeOfDay(hour: 0, minute: 0));
          if (picked != null) {
            setState(() {
              if (hintText == 'START') {
                controller.text = picked.format(context);
                this.start = picked;
              } else {
                controller.text = picked.format(context);
                this.end = picked;
              }
            });
          }
        });
  }

  /***FUNZIONI PER L'INSERIMENTO E CANCELLAZIONE DEGLI EL DALLA LISTA***/
  void insertItem(
      String subject, String notes, TimeOfDay start, TimeOfDay end) {
    final newIndex = 0; //posizione in cui inserire nella lista
    final newItem = //elemento da inserire nella lista
        ClassItem(
            subject: subject,
            notes: notes,
            start: start.format(context),
            end: end.format(context));
    dayToList[_daySelected]!.insert(newIndex, newItem);
    //ordinare la lista in base all'ora di inizio di un evento
    _dayKey[_daySelected]
        ?.currentState!
        .insertItem(newIndex, duration: Duration(milliseconds: 500));

    Save();
  }

  void removeItem(int index) {
    // Access the list for the selected day
    final list = dayToList[_daySelected];

    // Ensure the list exists and the index is valid
    if (list != null && index >= 0 && index < list.length) {
      final removedItem = list.removeAt(index);
      _dayKey[_daySelected]?.currentState!.removeItem(
            index,
            (context, animation) => ClassItemWidget(
              item: removedItem,
              animation: animation,
              onClicked: () {}, // No action needed for removed item
            ),
            duration: Duration(milliseconds: 500),
          );
      Save();
    }
  }
  /********************************************************/

  void Save() async {
    await WeekPreferences.setDay2List(dayToList);
  }
}
