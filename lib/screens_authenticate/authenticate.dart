
import 'package:book_tickets_app/screens_authenticate/rejister_screen.dart';
import 'package:book_tickets_app/screens_authenticate/signIn.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn)
    {
      return LoginScreen(togggleView: toggleView,);
    }
    else
      return RegisterScreen(toggleView: toggleView,);
  }
}
