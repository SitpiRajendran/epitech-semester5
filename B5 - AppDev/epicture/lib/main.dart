// https://www.youtube.com/watch?v=qQ75cxc5q8o

import 'package:flutter/material.dart';
import 'package:test_flutter/screens/signIn.dart';
//import 'package:test_flutter/widgets/navBar.dart';

String theAccessToken = "";
String theRefreshToken = "";
String theUsername = "";
String theUserID = "";
String theClientID = "d297fd441566f99";
String theUrl =
    "https://api.imgur.com/oauth2/authorize?client_id=$theClientID&response_type=token";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'my imgur',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme:
              Theme.of(context).textTheme.apply(displayColor: Colors.black)),
      home: ConnectionScreen(),
    );
  }
}
