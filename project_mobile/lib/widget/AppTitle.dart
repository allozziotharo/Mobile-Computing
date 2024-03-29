//materiale standard
import 'package:flutter/material.dart';

Widget appTitle = Container(
  margin: EdgeInsets.only(top: 50),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add_a_photo_rounded),
      ),
      Text('TITLE PROJ', style: TextStyle(color: Colors.black, fontSize: 30)),
    ],
  ),
);
