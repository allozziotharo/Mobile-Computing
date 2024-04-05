import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
/////////////////////////////////////////////////////////////////////////////////

//CLASSE DELLA SINGOLA VOCE DELLA TO-DO LIST
class Task{
  bool? complete;
  String? title;
  int? priority;

//costruttore Task item
  Task({
    this.title,
    this.complete = false,
    this.priority = null,
  });

  Task.fromMap(Map map) {
    this.title = map['title'];
    this.complete = map['complete'];
    this.priority = map['priority'];
  }

  Map toMap(){
    return {'title': this.title,
            'complete' :this.complete,
            'priority' : this.priority};
  }

}

