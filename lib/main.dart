import 'package:book_tickets_app/models/user.dart';
import 'package:book_tickets_app/services/auth.dart';
import 'package:book_tickets_app/utils/app_styles.dart';
import 'package:book_tickets_app/wrapper/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<CustomUser?>.value(
      catchError: (_,__){
        return null;
      },
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: primary,
        ),
        home: const Wrapper(),
      ),
    );
  }
}

