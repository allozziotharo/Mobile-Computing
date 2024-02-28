//materiale standard
import 'package:flutter/material.dart';

//WIDGET CHE CONTIENE LA COLONNA DI TEXTFIELD PER (USERNAME-PASSWORD)
Widget user_pass_tf = Column(
  children: [
    TextField(
      style: TextStyle(color: Colors.deepPurple),
      decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: 'Username',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    ),
    const SizedBox(height: 30),
    TextField(
      style: TextStyle(color: Colors.black),
      obscureText: true,
      decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    ),
    const SizedBox(height: 30),
  ],
);

//WIDGET CHE CONTIENE LA COLONNA DI TEXTFIELD PER (EMAIL-USERNAME-PASSWORD)
Widget registrationTextFields = Column(
  children: [
    TextField(
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: 'Email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    ), //TextField Email
    const SizedBox(
      height: 30,
    ),
    user_pass_tf,
  ],
);
