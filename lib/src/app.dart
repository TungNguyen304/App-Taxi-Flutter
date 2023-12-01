import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/resources/home-page.dart';
import 'package:flutter_application_1/src/resources/login-page.dart';

class App extends StatelessWidget {
const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}