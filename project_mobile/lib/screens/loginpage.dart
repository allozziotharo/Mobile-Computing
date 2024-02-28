//materiale standard
import 'package:flutter/material.dart';
//import per usare route
import 'package:project_mobile/route/route.dart' as route;

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

Widget username_passTextfield = Column(
  children: [
    TextField(
      style: TextStyle(color: Colors.deepPurple),
      decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: 'Username',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    ),
    SizedBox(height: 30),
    TextField(
      style: TextStyle(color: Colors.black),
      obscureText: true,
      decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          hintText: 'Password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    ),
    SizedBox(height: 30),
  ],
);

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
                    username_passTextfield, // widget che contiene textfield username e password
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('sei nuovo?',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 14)),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(
                                  context, route.signupPage),
                              child: Text('Sign In',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                      fontSize: 14)),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.black,
                          child: IconButton(
                            color: Colors.white,
                            onPressed: () =>
                                Navigator.pushNamed(context, route.homePage),
                            icon: Icon(Icons.arrow_forward),
                          ),
                        ),
                      ],
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
