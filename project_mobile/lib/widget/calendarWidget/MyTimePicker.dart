import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class MyTimePicker extends StatefulWidget {
  final String pickerText; //la frase da visualizzare sopra al timePicker
  final Function(TimeOfDay)
      onTimeConfirmed; //callback function per restituire l'orario scelto in questa classe

  MyTimePicker({required this.pickerText, required this.onTimeConfirmed});

  @override
  State<MyTimePicker> createState() => _MyTimePickerState();
}

class _MyTimePickerState extends State<MyTimePicker> {
  var _hour = 0;
  var _minute = 0;
  var _timeFormat = "AM";

  /* non mi serve credo
  @override
  void initState() {
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //quello che c'è scritto sopra (preview dell'ora selezionata)
          /*  non mi interessa per ora far vedere l'ora corrente mentre viene scelta
            Text("Pick Your Time! ${_hour}:${_minute} ${_timeFormat}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(
              height: 20,
            ),*/
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.pickerText,
                    style: TextStyle(color: Colors.white, fontSize: 24)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //picker dell'ora
                    NumberPicker(
                      minValue: 0,
                      maxValue: 12,
                      value: _hour,
                      zeroPad: true,
                      infiniteLoop: true,
                      itemWidth: 60,
                      itemHeight: 40,
                      onChanged: (value) {
                        setState(() {
                          _hour = value;
                        });
                      },
                      textStyle:
                          const TextStyle(color: Colors.blueGrey, fontSize: 20),
                      selectedTextStyle:
                          const TextStyle(color: Colors.white, fontSize: 30),
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.white,
                            ),
                            bottom: BorderSide(color: Colors.white)),
                      ),
                    ),
                    //picker dei minuti
                    NumberPicker(
                      minValue: 0,
                      maxValue: 59,
                      value: _minute,
                      zeroPad: true,
                      infiniteLoop: true,
                      itemWidth: 60,
                      itemHeight: 40,
                      onChanged: (value) {
                        setState(() {
                          _minute = value;
                        });
                      },
                      textStyle:
                          const TextStyle(color: Colors.blueGrey, fontSize: 20),
                      selectedTextStyle:
                          const TextStyle(color: Colors.white, fontSize: 30),
                      decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(
                              color: Colors.white,
                            ),
                            bottom: BorderSide(color: Colors.white)),
                      ),
                    ),
                    //picker AM / PM
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _timeFormat = "AM";
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                                color: _timeFormat == "AM"
                                    ? Colors.lightBlue[900]
                                    : Colors.lightBlue[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                )),
                            child: const Text(
                              "AM",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _timeFormat = "PM";
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 8),
                            decoration: BoxDecoration(
                                color: _timeFormat == "PM"
                                    ? Colors.lightBlue[900]
                                    : Colors.lightBlue[100],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                )),
                            child: const Text(
                              "PM",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          confirmTime(_hour, _minute, _timeFormat);
                        });
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //funzione che restituisce l'orario
  void confirmTime(int hour, int minute, String format) {
    TimeOfDay time = TimeOfDay(hour: hour, minute: minute);
    if (format == "PM") {
      time.replacing(hour: time.hour + 12);
    }
    widget.onTimeConfirmed(
        time); //così la restituisce alla classe che chiama il timePicker
  }
}
