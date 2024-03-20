import 'package:flutter/material.dart';
import 'package:project_mobile/widget/DayItem.dart';

class DayItemWidget extends StatelessWidget {
  final String day;
  //una lista di eventi ?

  const DayItemWidget({required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      width: 100,
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.blueGrey[600]),
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class WeekPage extends StatefulWidget {
  @override
  _WeekPageState createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  //controller per mostrare nei textfield le ore che sono state scelte
  TextEditingController _timeControllerStart = TextEditingController();
  TextEditingController _timeControllerEnd = TextEditingController();
  /******************************************************/

  //serve per accedere agli elementi dell' AnimatedList
  Map<String, GlobalKey<AnimatedListState>> _dayKey = {
    "lunedì": GlobalKey<AnimatedListState>(),
    "martedì": GlobalKey<AnimatedListState>(),
    "mercoledì": GlobalKey<AnimatedListState>(),
    "giovedì": GlobalKey<AnimatedListState>(),
    "venerdì": GlobalKey<AnimatedListState>(),
  };

  //stringa che stampa il giorno corrente
  String _daySelected = "";
  //mappa <giorno, lista_del_giorno>
  Map<String, List<ClassItem>> dayToList = {
    "lunedì": [],
    "martedì": [],
    "mercoledì": [],
    "giovedì": [],
    "venerdì": [],
  };
  /***********************************/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("your week"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _daySelected = "lunedì";
                            });
                          },
                          child: DayItemWidget(day: "lun")),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _daySelected = "martedì";
                            });
                          },
                          child: DayItemWidget(day: "mar")),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _daySelected = "mercoledì";
                            });
                          },
                          child: DayItemWidget(day: "mer")),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _daySelected = "giovedì";
                            });
                          },
                          child: DayItemWidget(day: "gio")),
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _daySelected = "venerdì";
                            });
                          },
                          child: DayItemWidget(day: "ven")),
                    ])),
                SizedBox(height: 20),
                Text(
                  "day selected: " + _daySelected,
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
          if (_daySelected.isNotEmpty) // Check if a day is selected
            Expanded(
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
            )
          else
            Center(
              child: Text(
                "select a day to see events",
                style: TextStyle(fontSize: 20),
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => readData(),
      ),
    );
  }

  //funzione che rimuove un list item invocata dal cestino
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
    }
  }

  void readData() {
    String subject = "";
    TimeOfDay start = TimeOfDay(hour: 0, minute: 0);
    TimeOfDay end = TimeOfDay(hour: 0, minute: 0);

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('insert subject data'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    subject = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'insert subject name',
                  ),
                ),
                TextField(
                  controller: _timeControllerStart,
                  decoration: const InputDecoration(
                    labelText: "START",
                    filled: true,
                    prefixIcon: const Icon(Icons.access_time),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                        context: context, initialTime: start);
                    if (picked != null) {
                      setState(() {
                        _timeControllerStart.text = picked.format(context);
                        start = picked;
                      });
                    }
                  },
                ),
                TextField(
                  controller: _timeControllerEnd,
                  decoration: const InputDecoration(
                    labelText: "END",
                    filled: true,
                    prefixIcon: const Icon(Icons.access_time),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final TimeOfDay? picked = await showTimePicker(
                        context: context, initialTime: end);
                    if (picked != null) {
                      setState(() {
                        _timeControllerEnd.text = picked.format(context);
                        end = picked;
                      });
                    }
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                child: Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('PROCEED'),
                onPressed: () {
                  insertItem(subject, start, end);
                  _timeControllerStart.text = '';
                  _timeControllerEnd.text = '';
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //funzione che chiama il costruttore di list item e lo inserisce nella lista
  void insertItem(String subject, TimeOfDay start, TimeOfDay end) {
    final newIndex = 0;
    final newItem = ClassItem(subject: subject, start: start, end: end);
    dayToList[_daySelected]!.insert(newIndex, newItem);
    _dayKey[_daySelected]
        ?.currentState!
        .insertItem(newIndex, duration: Duration(milliseconds: 500));
  }
}
