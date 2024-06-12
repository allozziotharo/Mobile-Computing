import 'package:flutter/material.dart';

class Event {
  final String titleEvent; // -> string con il titolo dell'evento
  final DateTime dateEvent; // -> vorrei un formato del tipo "Wed, dd/mm/yy"
  final TimeOfDay timeEvent; // -> vorrei un formato del tipo "2:20 pm"

  Event(
      {required this.titleEvent,
      required this.dateEvent,
      required this.timeEvent});
}
