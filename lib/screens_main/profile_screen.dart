import 'package:flutter/material.dart';

import '../services/auth.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () async{
            await _auth.signOut();
          },
          child: Text('Logout'),
          style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(55)),
        ),
      ),
    );
  }
}
