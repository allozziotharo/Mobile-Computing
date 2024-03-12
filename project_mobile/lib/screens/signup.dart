//materiale standard
import 'package:flutter/material.dart';
import 'package:project_mobile/widget/TextFields.dart';
import 'package:project_mobile/widget/CustomRow.dart';

//schermata di registrazione
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/sfondo_login.jpg'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            //questo container ha un messaggio di benvenuto
            Container(
              padding: EdgeInsets.only(left: 35, top: 110),
              child: Text('Benvenuto!',
                  style: TextStyle(color: Colors.white, fontSize: 33)),
            ), //Container
            //questo container contiene le caselle di testo per l'email,username e password
            SingleChildScrollView(
              //QUESTA PARTE DI CODICE SI PUO' SICURAMENTE ALLEGGERIRE
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          registrationTextFields,
                          CustomRow(buttonText: 'Log In'),
                        ],
                      ),
                    ),
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
