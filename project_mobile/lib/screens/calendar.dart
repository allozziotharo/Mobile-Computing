//materiale standard
import 'package:flutter/material.dart';
//import per il calendario
import 'package:table_calendar/table_calendar.dart';
//import per usare route
import 'package:project_mobile/route/route.dart' as route;

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  //così ho il giorno corrente
  DateTime today = DateTime.now();

  //metodo per evidenziare un altro giorno
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Calendar',
              style: TextStyle(color: Colors.tealAccent, fontSize: 16))),
      body: calendar(),
    );
  }

  Widget calendar() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text("selected day = " + today.toString().split(" ")[0]),
          Container(
            child: TableCalendar(
              locale: "en_Us",
              rowHeight: 43,
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: DateTime.utc(2015, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              onDaySelected: _onDaySelected,
            ),
          ),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blueGrey,
                child: IconButton(
                  onPressed: () => Navigator.pushNamed(context, route.homePage),
                  icon: Icon(Icons.home),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
