//materiale standard
import 'package:flutter/material.dart';
//import per usare route
import 'package:project_mobile/route/route.dart' as route;

//schermata di registrazione
class SignUpPage extends StatefulWidget{
    @override
    _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
    @override
    Widget build (BuildContext context){
        return Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/sfondo_login.jpg'), fit: BoxFit.cover)),//BoxDecoration
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                    children: [
                        //questo container ha un messaggio di benvenuto
                        Container(
                            padding: EdgeInsets.only(left: 35, top: 110),
                            child: Text('Benvenuto!', style: TextStyle(color: Colors.white, fontSize: 33)),
                        ),//Container
                        //questo container contiene le caselle di testo per l'email,username e password
                        SingleChildScrollView(
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
                                                    TextField(
                                                        style: TextStyle(color: Colors.black),
                                                        decoration: InputDecoration(
                                                            fillColor: Colors.grey.shade100,
                                                            filled: true,
                                                            hintText: 'Email',
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                                    ),//TextField Email
                                                    //con una sizedbox vuota aggiungo spazio tra i textField
                                                    SizedBox(height: 30),
                                                    TextField(
                                                        style: TextStyle(color: Colors.black), //visto che il testo è oscurato mesa non serve che dico color: Colors.black
                                                        decoration: InputDecoration(
                                                            fillColor: Colors.grey.shade100,
                                                            filled: true,
                                                            hintText: 'Username',
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                                    ),//TextField Username
                                                    //con una sizedbox vuota aggiungo spazio tra i textField
                                                    SizedBox(height: 30),
                                                    TextField(
                                                        style: TextStyle(color: Colors.black),
                                                        obscureText: true,
                                                        decoration: InputDecoration(
                                                            fillColor: Colors.grey.shade100,
                                                            filled: true,
                                                            hintText: 'Password',
                                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                                                    ),//TextField password
                                                    //con una sizedbox vuota aggiungo spazio tra i textField
                                                    SizedBox(height: 30),
                                                    Row (
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                            TextButton (
                                                                onPressed: () => Navigator.pushNamed(context, route.loginPage),//ritorna alla pagina di log in
                                                                child: Text('Log In',style: TextStyle(decoration: TextDecoration.underline, color: Colors.black, fontSize: 18)),
                                                            ),
                                                            CircleAvatar(
                                                                radius: 30,
                                                                backgroundColor: Colors.black,
                                                                child: IconButton(
                                                                    color: Colors.white,
                                                                    onPressed: () => Navigator.pushNamed(context, route.homePage), //logica che fa la registrazione da implementare
                                                                    icon: Icon(Icons.arrow_forward),
                                                                ),
                                                            ),
                                                        ],
                                                    )//Row
                                                ],//children di column
                                            ),//column
                                        ),//Container
                                    ],//children di column
                                ),//column
                            ),//Container
                        ),//SingleChildScrollView
                    ],//children di stack
                ),//Stack
            ),//Scaffold
        );//Container
    }//build()
}//_SignUpState