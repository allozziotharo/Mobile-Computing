//materiale standard
import 'package:flutter/material.dart';

import 'package:project_mobile/widget/TextFields.dart';
import 'package:project_mobile/widget/CustomRow.dart';
import 'package:project_mobile/widget/AppTitle.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login_background.jpg'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appTitle, //widget che contiene icona e titolo dell'app definito sopra
                Container(
                  padding: EdgeInsets.only(left: 35, top: 90),
                  child: const Text('Log In',
                      style: TextStyle(color: Colors.black, fontSize: 24)),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.35,
                  left: 30,
                  right: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    user_pass_tf, //WIDGET DICHIARATI IN textfields.dart e CustomRow.dart
                    CustomRow(buttonText: 'Sign Up'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
