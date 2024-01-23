import 'package:book_tickets_app/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () async{
            dynamic result =  await _auth.signInAnon();
            if (result == null)
            {
              print("Error");
            }
            else{
              print(result.uID);
            }
          },
          child: Text('Login anonymously'),
          style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(55)),
        ),
      ),
    );
  }
}
