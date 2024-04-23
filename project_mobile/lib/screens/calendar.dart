//materiale standard
import 'package:flutter/material.dart';
//import per il calendario
import 'package:table_calendar/table_calendar.dart';

//import per usare route
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

  //per inizializzare lo stato?
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay; //inizialmente il giorno selezionato è oggi
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    super.dispose();
  }

  //metodo per evidenziare un altro giorno
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  //metodo che restituisce la lista degli eventi del giorno corrente
  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  } //se il giorno corrente non ha eventi allora -> lista vuota

  /*METODO BUILD*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: const Text('Calendar',
              style: TextStyle(color: Colors.tealAccent, fontSize: 16))),
      body: calendar(),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_circle_outline_sharp),
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
                          setState(() {
                            if (events[_selectedDay] == null) {
                              events[_selectedDay!] = <Event>[];
                            }
                            events[_selectedDay]!
                                .add(Event(_eventController.text));
                            _eventController.text = "";
                            _selectedEvents.value =
                                _getEventsForDay(_selectedDay!);
                          });
                          Navigator.of(context).pop();
                        },
                        child: const Text("submit"),
                      )
                    ],
                  );
                });
          }),
    );
  }
  /*FINE BUILD*/

  Widget calendar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Text("DAY SELECTED : " + _selectedDay.toString().split(" ")[0]),
          Container(
              child: TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2031),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            //locale: "en_US",
            //rowHeight: 43,
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            onDaySelected: _onDaySelected,
            eventLoader: _getEventsForDay,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          )),
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
                            onTap: () => null,
                            title: Text("${value[index].title}"),
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
