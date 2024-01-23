import 'package:book_tickets_app/models/user.dart';
import 'package:book_tickets_app/screens_authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens_main/bottom_bar.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<CustomUser?>(context);

    //return either home or authenticate widget
    return user == null ? Authenticate() : BottomBar();
  }
}
