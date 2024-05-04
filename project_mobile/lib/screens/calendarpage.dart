//materiale standard
import 'package:flutter/material.dart';
import 'package:project_mobile/widget/calendarWidget/CalendarContainer.dart';
import 'package:project_mobile/widget/calendarWidget/Event.dart';
import 'package:project_mobile/widget/calendarWidget/MyTimePicker.dart';

//import per il calendario
import 'package:table_calendar/table_calendar.dart';

//import per usare route

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  /*ATTRIBUTI*/
  String? _titleEvent;
  TimeOfDay? _timeEvent;
  DateTime? _selectedDay; //giorno selezionato
  DateTime _focusedDay = DateTime.now(); //giorno evidenziato

  //TextEditingController _eventController = TextEditingController();

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
            readEventData();
          }),
    );
  }
  /*FINE BUILD*/

  /*BODY DELLA PAGINA CONTIENE IL CALENDARIO E LA LISTA DEGLI EVENTI DEL GIORNO*/
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
                        return CalendarContainer(event: value[index]);
                      });
                }),
          ),
        ],
      ),
    );
  }

  void readEventData() {
    //con questo dialog faccio inserire all'utente il titolo dell'evento
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            title: const Text("event creation"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildTextField("event Name"),
                MyTimePicker(
                    //pickerText: "insert event time",
                    onTimeConfirmed: (time) {
                  _timeEvent = time;
                }),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  insertEvent(_titleEvent!, _timeEvent!);
                  Navigator.of(context).pop();
                },
                child: const Text("insert"),
              )
            ],
          );
        });
  }

  //funzione che fa l'inserimento dell'evento (prende come parametro String, e orario)
  //il giorno lo prende dal giorno evidenziato nel calendario
  void insertEvent(String titleEvent, TimeOfDay timeEvent) {
    setState(() {
      if (events[_selectedDay] == null) {
        //se per il giorno selezionato non c'è nulla
        events[_selectedDay!] = <Event>[]; //allora metto una lista vuota
      }
      events[_selectedDay]!.add(Event(
          //poi aggiungo alla lista
          titleEvent: _titleEvent!,
          dateEvent: _selectedDay!,
          timeEvent: _timeEvent!));
      _selectedEvents.value = _getEventsForDay(_selectedDay!);
    });
  }

  // restituisce il textfield
  Widget buildTextField(String hintText) {
    return TextField(
      onChanged: (value) {
        _titleEvent = value;
      },
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
