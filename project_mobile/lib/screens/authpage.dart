import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:project_mobile/widget/TextFields.dart';
import 'package:project_mobile/widget/CustomRow.dart';

import 'package:project_mobile/services/auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();

}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLogin = false;

Future<void> signIn() async {
  try {
    await Auth().signiInWithEmailAndPassword(email: _email.text, password: _password.text);
  }on FirebaseAuthException catch (error) {}  //per ora unhandled exception
} 

Future<void> createUser() async {
  try {
    await Auth().createUserWithEmailAndPassword(email: _email.text, password: _password.text);
  }on FirebaseAuthException catch (error) {}  //per ora unhandled exception
} 



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
                          TextField( //email 
                            controller: _email,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: 'Username',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          ),
                          TextField(
                            controller: _password,
                            style: TextStyle(color: Colors.black),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: 'Password',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                          ),
                          
                          ElevatedButton(onPressed: (){
                            isLogin ? signIn() : createUser() //a seconda del valore di isLogin (variabile d'istanza), o fai l'uno : l'altro
                          },
                              child: Text(isLogin ? 'Accedi' : 'Registrati')),
                          
                          TextButton(onPressed: () {
                            setState(() {
                              isLogin = !isLogin;
                            });
                          }, child: Text(isLogin? 'Non hai un account? Registrati' : 'Hai un account? Accedi'))      
                        ],   //riprendi da 16.58 del video
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
