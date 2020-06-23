import 'package:bhavintailors/LandingPage.dart';
import 'package:bhavintailors/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      builder:(context)=>Auth(),
      child: MaterialApp(
        title: 'Bhavin Tailors',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromRGBO(255, 26, 26, 1),
        ),
        home: LandingPage(),
      ),
    );
  }
}





