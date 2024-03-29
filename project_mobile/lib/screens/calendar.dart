//materiale standard
import 'package:flutter/material.dart';
//import per il calendario
import 'package:table_calendar/table_calendar.dart';

//import per usare route
import 'package:project_mobile/route/route.dart' as route;
import 'package:project_mobile/widget/calendarWidget/Event.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  /*ATTRIBUTI*/
  DateTime _focusedDay = DateTime.now(); //giorno evidenziato
  DateTime? _selectedDay; //giorno selezionato

  TextEditingController _eventController = TextEditingController();
  //eventi del giorno
  late final ValueNotifier<List<Event>> _selectedEvents;

  //mappa giorno -> lista di eventi
  Map<DateTime, List<Event>> events = {};
  /*FINE ATTRIBUTI*/

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  //metodo per evidenziare un altro giorno
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, _focusedDay)) {
      setState(() {
        _selectedDay = day;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(day);
      });
    }
  }

  //metodo che restituisce la lista degli eventi del giorno corrente
  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Calendar',
              style: TextStyle(color: Colors.tealAccent, fontSize: 16))),
      body: calendar(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    scrollable: true,
                    title: const Text("Event Name"),
                    content: Padding(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          controller: _eventController,
                        )),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          events.addAll({
                            _selectedDay!: [Event(_eventController.text)]
                          });
                          Navigator.of(context).pop(); //esco dal dialog
                          _selectedEvents.value =
                              _getEventsForDay(_selectedDay!);
                        },
                        child: const Text("submit"),
                      )
                    ],
                  );
                });
          }),
    );
  }

  Widget calendar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text("DAY SELECTED : " + _selectedDay.toString().split(" ")[0]),
          Container(
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 43,
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              focusedDay: _focusedDay,
              firstDay: DateTime.utc(2020),
              lastDay: DateTime.utc(2031),
              onDaySelected: _onDaySelected,
              eventLoader: _getEventsForDay,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ValueListenableBuilder<List<Event>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            onTap: () => print(""),
                            title: Text('${value[index]}'),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }
}


/*CI SONO ERRORI*/
