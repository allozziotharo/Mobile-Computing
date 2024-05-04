//materiale standard
import 'package:flutter/material.dart';
import 'package:project_mobile/widget/calendarWidget/Event.dart';
import 'package:intl/intl.dart';

class CalendarContainer extends StatefulWidget {
  final Event event;

  CalendarContainer({required this.event});

  @override
  State<CalendarContainer> createState() => _CalendarContainerState();
}

class _CalendarContainerState extends State<CalendarContainer> {
  bool completeness = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
      child: ListView(
        padding: EdgeInsets.zero,
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 3,
                    color: Color(0x33000000),
                    offset: Offset(
                      0,
                      1,
                    ),
                  )
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Text(widget.event.titleEvent,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                color: Color(0xFF14181B),
                                fontSize: 24,
                                letterSpacing: 0,
                                fontWeight: FontWeight.w500,
                              )),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                                child: Card(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  color: Color(0x4DEE8B60),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        8, 4, 8, 4),
                                    child:
                                        Text(formatTime(widget.event.timeEvent),
                                            style: TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              color: Color(0xFFEE8B60),
                                              fontSize: 14,
                                              letterSpacing: 0,
                                              fontWeight: FontWeight.normal,
                                            )),
                                  ),
                                ),
                              ),
                              Text(formatDate(widget.event.dateEvent),
                                  style: TextStyle(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: Color(0xFF14181B),
                                    fontSize: 14,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.normal,
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                        //da cambiare con la checkBox
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                          borderRadius: BorderRadius.circular(8),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Color(0xFFE0E3E7),
                            width: 1,
                          ),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Checkbox(
                          value: completeness,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                completeness = value;
                              });
                            }
                            ;
                          },
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  //prende come parametro una data -> "Wed, 12/03/24"
  String formatDate(DateTime day) {
    // Create a DateFormat object with the desired pattern
    final DateFormat formatter = DateFormat('EEE, d/M/y');
    // Format the DateTime object and return the String
    return formatter.format(day);
  }

  //prende come parametro un orario -> "2:20 pm"
  String formatTime(TimeOfDay time) {
    // Get hour and minute from TimeOfDay
    final int hour = time.hour;
    final int minute = time.minute;

    // Use String formatting for desired output
    String formattedTime =
        '${hour.toString()}:${minute.toString().padLeft(2, '0')}';

    // Check if it's past noon and add meridian indicator
    if (hour >= 12) {
      formattedTime = formattedTime +
          (hour == 12 ? ' pm' : ':${minute.toString().padLeft(2, '0')} pm');
    } else {
      formattedTime = formattedTime +
          (hour == 0 ? ' am' : ':${minute.toString().padLeft(2, '0')} am');
    }
    return formattedTime;
  }
}
