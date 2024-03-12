//materiale standard
import 'package:flutter/material.dart';
//import per usare route
import 'package:project_mobile/route/route.dart' as route;

class CustomRow extends StatelessWidget {
  final String buttonText;
  //deve prendere come parametro il nome della classe dove voglio andare
  const CustomRow({Key? key, required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
          onPressed: () {
            if (buttonText == 'Log In') {
              Navigator.pushNamed(context, route.loginPage);
            } else if (buttonText == 'Sign Up') {
              Navigator.pushNamed(context, route.signupPage);
            }
          },
          child: Text(buttonText,
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.black,
                fontSize: 26,
              )),
        ),
        //QUESTO BOTTONE PORTA ALLA SCHERMATA DI HOME ANDRA' IMPLEMENTATA LA LOGICA PER CUI SONO DA VERIFICARE LE CREDENZIALI
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.black,
          child: IconButton(
              color: Colors.white,
              onPressed: () => Navigator.pushNamed(context, route.homePage),
              icon: Icon(Icons.arrow_forward)),
        ),
      ],
    );
  }
}
