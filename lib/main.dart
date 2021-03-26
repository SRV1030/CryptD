import 'package:CryptD/screens/HomePage.dart';
import 'package:flutter/material.dart';
// import './screens/HomePage.dart';
import 'package:CryptD/screens/EncryptDecryptAll.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CruptD',
      theme: ThemeData(        
        primarySwatch: Colors.grey,
        accentColor: Colors.white,
        canvasColor: Color(0xffafafaf),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:EncryptDecryptAll(),
      routes: {
        MyHomePage.routeName: (ctx)=> MyHomePage(),
      },
    );
  }
}

